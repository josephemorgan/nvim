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
