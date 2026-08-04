-- Buffer-local <leader>f keymaps surfaced by the active buffer's filetype.
local M = {}

---@class LangModule
---@field filetypes string[]                  -- filetypes that activate this group
---@field detect? fun(buf: integer): boolean  -- extra gate (e.g. project detection)
---@field spec wk.Spec                        -- which-key spec rooted at <leader>f

---@type LangModule[]
local registry = {
	require("keybinds.lang.angular"),
	require("keybinds.lang.flutter"),
	require("keybinds.lang.dotnet"),
}

local function all_filetypes()
	local seen, fts = {}, {}
	for _, lang in ipairs(registry) do
		for _, ft in ipairs(lang.filetypes) do
			if not seen[ft] then
				seen[ft] = true
				fts[#fts + 1] = ft
			end
		end
	end
	return fts
end

local function apply(buf)
	local ft = vim.bo[buf].filetype
	for _, lang in ipairs(registry) do
		if vim.tbl_contains(lang.filetypes, ft) and (not lang.detect or lang.detect(buf)) then
			-- deepcopy: which-key mutates the spec (and its children) in place during
			-- parse, and `require` caches the module table across calls. `buffer` lives
			-- inside the spec (it's an inheriting field, so it cascades to children) --
			-- passing it as add()'s 2nd arg is silently ignored, leaking global keymaps.
			local spec = vim.deepcopy(lang.spec)
			spec.buffer = buf
			require("which-key").add(spec)
		end
	end
end

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("UserLangKeymaps", { clear = true }),
		pattern = all_filetypes(),
		callback = function(args)
			apply(args.buf)
		end,
		desc = "Register language-specific <leader>f keymaps",
	})
	-- Cover buffers already loaded before which-key's config ran (startup file).
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			apply(buf)
		end
	end
end

return M
