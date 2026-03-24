local languages = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"javascript",
	"typescript",
	"html",
	"python",
	"diff",
	"markdown",
	"markdown_inline",
	"angular",
	"scss",
	"c_sharp",
	"dart",
	"yaml",
	"regex",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			ensure_installed = languages,
			fold = { enable = true },
			highlight = { enable = true },
			-- indent = { enable = true },
			incremental_selection = { enable = true },
		},
		-- config = function(_, opts)
		-- 	require("nvim-treesitter").setup(opts)
		--
		-- 	require("nvim-treesitter").install(opts.ensure_installed)
		-- end,
	},
}
