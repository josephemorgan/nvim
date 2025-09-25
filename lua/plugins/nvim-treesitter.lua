return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"elixir",
			"heex",
			"javascript",
			"typescript",
			"html",
			"python",
			"diff",
			"markdown",
			"markdown_inline",
		},
		sync_install = false,
		highlight = { enable = true },
	},
}
