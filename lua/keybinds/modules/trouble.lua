return {
	"<leader>r",
	group = "T[r]ouble",
	{
		"<leader>rd",
		"<cmd>Trouble diagnostics toggle<cr>",
		desc = "[d]iagnostics",
	},
	{
		"<leader>rb",
		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		desc = "[b]uffer Diagnostics",
	},
	{
		"<leader>rs",
		"<cmd>Trouble symbols toggle focus=false<cr>",
		desc = "[s]ymbols",
	},
	{
		"<leader>rl",
		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		desc = "[l]SP Definitions / references / ...",
	},
	{
		"<leader>ro",
		"<cmd>Trouble loclist toggle<cr>",
		desc = "L[o]cation List (Trouble)",
	},
	{
		"<leader>rq",
		"<cmd>Trouble qflist toggle<cr>",
		desc = "[q]uickfix List (Trouble)",
	},
}
