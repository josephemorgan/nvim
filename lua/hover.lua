local M = {}

local state = {
	win = nil,
	buf = nil,
	source_win = nil,
	source_buf = nil,
	pos = nil,
	view = nil,
}

local function reset_state()
	state.win = nil
	state.buf = nil
	state.source_win = nil
	state.source_buf = nil
	state.pos = nil
	state.view = nil
end

local function close_float()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
	end
	reset_state()
end

local function has_dap_session()
	local ok, dap = pcall(require, "dap")
	if not ok then
		return false
	end
	return dap.session() ~= nil
end

local function current_signature()
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_get_current_buf()
	local cur = vim.api.nvim_win_get_cursor(win)
	return {
		buf = buf,
		win = win,
		lnum = cur[1] - 1,
		col = cur[2],
		word = vim.fn.expand("<cword>"),
		cexpr = vim.fn.expand("<cexpr>"),
	}
end

local function same_spot(a, b)
	return a and b and a.buf == b.buf and a.lnum == b.lnum and a.word == b.word
end

local function format_diagnostics(diagnostics)
	local lines = {}
	for _, d in ipairs(diagnostics) do
		local severity = vim.diagnostic.severity[d.severity]
		local source = d.source and (" · " .. d.source) or ""
		table.insert(lines, string.format("**[%s%s]** %s", severity, source, d.message))
	end
	return lines
end

local function has_evaluatable_expression(sig)
	return sig and sig.cexpr ~= nil and sig.cexpr:match("%S") ~= nil
end

local function dap_provider_available(sig)
	return has_dap_session() and has_evaluatable_expression(sig)
end

local function header_line(sig)
	if dap_provider_available(sig) then
		return "`LSP ▸ DAP`  *(Tab: switch to DAP)*"
	end
	if has_dap_session() then
		return "`LSP ─ (DAP: nothing to evaluate)`"
	end
	return "`LSP ─ (DAP unavailable)`"
end

local function register_win_cleanup(win)
	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(win),
		once = true,
		callback = function()
			if state.win == win then
				reset_state()
			end
		end,
	})
end

local function open_float(lines, sig)
	local buf, win = vim.lsp.util.open_floating_preview(lines, "markdown", {
		focus = false,
		border = "rounded",
		max_height = math.floor(vim.o.lines * 0.4),
		max_width = math.floor(vim.o.columns * 0.6),
	})
	state.buf = buf
	state.win = win
	state.pos = sig
	state.source_win = sig.win
	state.source_buf = sig.buf

	vim.keymap.set("n", "<Tab>", function()
		M.switch_to_dap()
	end, { buffer = buf, silent = true, nowait = true, desc = "Hover: switch to DAP" })

	register_win_cleanup(win)
end

local function compose_prefix(sig, view)
	local lines = { header_line(sig), "---" }
	if view == "lsp+diag" then
		local diags = vim.diagnostic.get(sig.buf, { lnum = sig.lnum })
		for _, line in ipairs(format_diagnostics(diags)) do
			table.insert(lines, line)
		end
		table.insert(lines, "---")
	end
	return lines
end

local function show(lines, sig, view)
	-- Close prior float *after* we have new content so the transition is seamless
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
	end
	open_float(lines, sig)
	state.view = view
end

local function render(sig, requested_view)
	-- Snapshot whether this is a fresh press BEFORE the async callback runs
	local is_fresh = state.view == nil

	local function finalize(hover_lines)
		local effective_view = requested_view
		local has_hover = hover_lines and #hover_lines > 0

		-- Promote to lsp+diag on a fresh press if LSP produced nothing
		-- and the line has diagnostics (the "no hoverable symbol but has a
		-- diagnostic" case — fall straight to the diagnostic view).
		if is_fresh and not has_hover and effective_view == "lsp" then
			local has_diag = #vim.diagnostic.get(sig.buf, { lnum = sig.lnum }) > 0
			if has_diag then
				effective_view = "lsp+diag"
			end
		end

		local lines = compose_prefix(sig, effective_view)
		if has_hover then
			vim.list_extend(lines, hover_lines)
		end

		local has_diag_in_prefix = effective_view == "lsp+diag"
		if not has_diag_in_prefix and not has_hover then
			return
		end
		show(lines, sig, effective_view)
	end

	local clients = vim.lsp.get_clients({ bufnr = sig.buf, method = "textDocument/hover" })
	if #clients == 0 then
		finalize(nil)
		return
	end

	local params = vim.lsp.util.make_position_params(sig.win, "utf-16")
	vim.lsp.buf_request(sig.buf, "textDocument/hover", params, function(_, result)
		local hover_lines = nil
		if result and result.contents then
			hover_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
		end
		finalize(hover_lines)
	end)
end

function M.hover()
	local count = vim.v.count
	local sig = current_signature()

	-- Count prefix 3K: jump straight to DAP widget
	if count == 3 then
		if not has_dap_session() then
			vim.notify("No active DAP session", vim.log.levels.INFO)
			return
		end
		if not has_evaluatable_expression(sig) then
			vim.notify("Nothing to evaluate under cursor", vim.log.levels.INFO)
			return
		end
		close_float()
		require("dap.ui.widgets").hover()
		return
	end

	-- Position changed since last press → reset view cycle
	if not same_spot(state.pos, sig) then
		state.view = nil
	end

	-- Count prefix 2K: jump straight to merged view
	if count == 2 then
		render(sig, "lsp+diag")
		return
	end

	local has_diag = #vim.diagnostic.get(sig.buf, { lnum = sig.lnum }) > 0

	if state.view == nil then
		render(sig, "lsp")
	elseif state.view == "lsp" then
		if has_diag then
			render(sig, "lsp+diag")
		else
			-- No diagnostics to toggle: focus the float (stock K-again behavior)
			if state.win and vim.api.nvim_win_is_valid(state.win) then
				vim.api.nvim_set_current_win(state.win)
			end
		end
	elseif state.view == "lsp+diag" then
		render(sig, "lsp")
	end
end

function M.switch_to_dap()
	if not has_dap_session() then
		vim.notify("No active DAP session", vim.log.levels.INFO)
		return
	end
	if not has_evaluatable_expression(state.pos) then
		vim.notify("Nothing to evaluate under cursor", vim.log.levels.INFO)
		return
	end
	local src_win = state.source_win
	close_float()
	if src_win and vim.api.nvim_win_is_valid(src_win) then
		vim.api.nvim_set_current_win(src_win)
	end
	require("dap.ui.widgets").hover()
end

function M.setup()
	local function register_listeners()
		local ok, dap = pcall(require, "dap")
		if not ok then
			return false
		end
		local key = "hover_overhaul"
		dap.listeners.after.event_stopped[key] = close_float
		dap.listeners.after.event_continued[key] = close_float
		dap.listeners.after.event_terminated[key] = close_float
		dap.listeners.after.event_exited[key] = close_float
		return true
	end

	if register_listeners() then
		return
	end

	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		once = true,
		callback = register_listeners,
	})
end

return M
