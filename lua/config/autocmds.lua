-- Autocommands configuration
local M = {}

function M.setup()
	local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

	-- Python settings
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup,
		pattern = "python",
		callback = function()
			vim.opt_local.expandtab = true
			vim.opt_local.softtabstop = 4
		end,
		desc = "Python indentation settings",
	})

	-- C# settings
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup,
		pattern = "cs",
		callback = function()
			vim.opt_local.expandtab = true
			vim.opt_local.softtabstop = 4
		end,
		desc = "C# indentation settings",
	})

	-- Source .nvim.lua on directory change
	vim.api.nvim_create_autocmd("DirChanged", {
		group = augroup,
		callback = function(args)
			local exrc_path = args.file .. "/.nvim.lua"
			if vim.fn.filereadable(exrc_path) == 1 then
				vim.cmd.source(vim.fn.fnameescape(exrc_path))
			end
		end,
		desc = "Source .nvim.lua when changing working directory",
	})

	-- Markdown prose settings
	vim.api.nvim_create_autocmd("FileType", {
		group = augroup,
		pattern = "markdown",
		callback = function()
			vim.opt_local.wrap = true
			vim.opt_local.linebreak = true
			vim.opt_local.spell = true
			vim.opt_local.conceallevel = 2
			vim.opt_local.formatoptions:append("t")

			local map = function(lhs, rhs)
				vim.keymap.set({ "n", "x" }, lhs, rhs, { buffer = true, expr = true, silent = true })
			end
			map("j", "v:count == 0 ? 'gj' : 'j'")
			map("k", "v:count == 0 ? 'gk' : 'k'")
			map("0", "'g0'")
			map("$", "'g$'")
		end,
		desc = "Markdown prose quality-of-life settings",
	})

	-- Highlight yanked text (best practice)
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = augroup,
		callback = function()
			vim.hl.on_yank()
		end,
		desc = "Briefly highlight yanked text",
	})
end

return M
