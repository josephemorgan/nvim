return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_win_position = "left"
		vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
		-- vim.g.db_ui_execute_on_save = 0  -- uncomment to require explicit execute instead of :w

		-- Optional, gitignored declarative connections.
		-- Copy lua/dbs.lua.example to lua/dbs.lua and fill in real URLs.
		local ok, dbs = pcall(require, "dbs")
		if ok then
			vim.g.dbs = dbs
		end
	end,
}
