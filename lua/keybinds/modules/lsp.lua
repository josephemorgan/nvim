local picker_config = require("keybinds.modules.picker_config")

return {
	"<leader>l",
	group = "[L]anguage Server",
	{
		"<leader>lh",
		function()
			vim.lsp.buf.signature_help()
		end,
		desc = "Signature [h]elp",
	},
	{
		"<C-.>",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code action",
	},
	{
		"<leader>la",
		function()
			vim.lsp.buf.code_action()
		end,
		desc = "Code [a]ction",
	},
	{
		"<leader>lR",
		function()
			vim.lsp.buf.rename()
		end,
		desc = "[r]ename",
	},
	{
		"<leader>ln",
		function()
			vim.diagnostic.jump({ count = 1, float = true })
		end,
		desc = "[n]ext Diagnostic",
	},
	{
		"<f8>",
		function()
			vim.diagnostic.jump({ count = 1, float = true })
		end,
		desc = "[n]ext Diagnostic",
	},
	{
		"<leader>lp",
		function()
			vim.diagnostic.jump({ count = -1, float = true })
		end,
		desc = "[p]revious Diagnostic",
	},
	{
		"<S-f8>",
		function()
			vim.diagnostic.jump({ count = -1, float = true })
		end,
		desc = "[p]revious Diagnostic",
	},
	{
		"<leader>lr",
		function()
			picker_config.lsp_references()
		end,
		desc = "Show [r]eferences",
	},
	{
		"<S-f12>",
		function()
			picker_config.lsp_references()
		end,
		desc = "Show references",
	},
	{
		"<leader>ld",
		function()
			picker_config.lsp_definitions()
		end,
		desc = "Show [d]efinitions",
	},
	{
		"<f12>",
		function()
			picker_config.lsp_definitions()
		end,
		desc = "Show Definitions",
	},
	{
		"<leader>lD",
		function()
			picker_config.lsp_type_definitions()
		end,
		desc = "Show Type [D]efinitions",
	},
	{
		"<leader>li",
		function()
			picker_config.lsp_implementations()
		end,
		desc = "Show [i]mplementations",
	},
}
