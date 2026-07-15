local picker_config = require("keybinds.modules.picker_config")

return {
	"josephemorgan/spacewalk.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim", -- or "folke/snacks.nvim"
	},
	opts = {
		roots = { os.getenv("DEV_DIR") }, -- scanned recursively for .git
		manual = { vim.fn.stdpath("config") }, -- always listed, no scan needed
	},
	keys = {},
	actions = {
		-- <C-p>: pick files in the chosen project
		["<C-p>"] = {
			desc = "Pick Files",
			fn = function()
				vim.notify("Pick Files in Project", vim.log.levels.INFO)
				picker_config.default()
				-- telescope: require("telescope.builtin").find_files({ cwd = dir })
			end,
		},
		-- <C-b>: browse files in the chosen project
		["<C-b>"] = {
			desc = "Browse Files",
			fn = function()
				vim.notify("Browse Files in Project", vim.log.levels.INFO)
				picker_config.explorer()
				-- oil:      require("oil").open(dir)
				-- netrw:    vim.cmd.edit(dir)
				-- telescope-file-browser:
				--   require("telescope").extensions.file_browser.file_browser({ cwd = dir })
			end,
		},
		-- <C-t>: open a terminal in the chosen project
		["<C-t>"] = {
			desc = "Open Terminal",
			fn = function(dir)
				vim.notify("Open Terminal in Project", vim.log.levels.INFO)
				Snacks.terminal(nil, { cwd = dir })
				-- builtin: vim.cmd.terminal()  -- inherits the tcd'd cwd already
			end,
		},
	},
}
