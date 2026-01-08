local picker_config = require("keybinds.modules.picker_config")

return {
	"<leader>s",
	group = "[s]earch",
	{
		"<c-p>",
		desc = "Smart Search",
		picker_config.default,
	},
	{
		"<leader>sb",
		desc = "Search [b]uffers",
		picker_config.buffers,
	},
	{
		"<leader>ss",
		desc = "Search Document [S]ymbols",
		picker_config.lsp_symbols,
	},
	{
		"<leader>sS",
		desc = "Search workspace [S]ymbols",
		picker_config.workspace_lsp_symbols,
	},
	{
		"<leader>sd",
		desc = "Search [d]iagnostics",
		picker_config.diagnostics,
	},
	{
		"<leader>sp",
		desc = "Search [p]ickers",
		picker_config.pickers,
	},
	{
		"<leader>sl",
		desc = "search [l]ines in buffer",
		picker_config.lines,
	},
	{
		"<leader>sg",
		desc = "search [g]rep",
		picker_config.grep,
	},
	{
		"<leader>sr",
		desc = "find [r]egisters",
		picker_config.registers,
	},
	{
		"<leader>sc",
		desc = "search [c]ommand history",
		picker_config.command_history,
	},
	{
		"<leader>sh",
		desc = "search [h]elp",
		picker_config.help,
	},
	{
		"<leader>sp",
		desc = "search [p]rojects",
		picker_config.projects,
	},
	{
		"<C-/>",
		desc = "search [p]rojects",
		picker_config.projects,
	},
	{
		"<leader>sG",
		desc = "search [G]it history",
		picker_config.git_history,
	},
	{
		"<leader>se",
		desc = "r[e]sume last search",
		picker_config.resume,
	},
	{
		"<leader>sC",
		desc = "Search [C]olorschemes",
		picker_config.colorscheme,
	},
	{
		"<leader>sm",
		desc = "Search [M]arks",
		picker_config.marks,
	},
	{
		"<leader>sf",
		desc = "Explore [f]iles",
		picker_config.explorer,
	},

	-- Jump Navigation
	{ "<leader>j", group = "[j]ump" },
	{
		"<leader>jj",
		mode = { "n", "x", "o" },
		function()
			require("flash").jump()
		end,
		desc = "[j]ump",
	},
	{
		"<leader>jt",
		function()
			require("flash").treesitter()
		end,
		desc = "Treesitter Jump",
	},
}
