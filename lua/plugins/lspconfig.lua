return {
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = { "williamboman/mason-lspconfig.nvim", "folke/neodev.nvim" },
		keys = {
			{ "K", ":lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
			{ "<leader>ss", ":lua vim.diagnostic.open_float()<CR>", desc = "Open Diagnostics" },
			{ "<leader>sy", ":lua require('telescope.builtin').lsp_document_symbols()<CR>", desc = "Document Symbols" },
			{ "<leader>sl", ":lua require('telescope.builtin').diagnostics()<CR>", desc = "List Diagnostics" },
			{ "<leader>sn", ":lua vim.diagnostic.goto_next()<CR>", desc = "Next Diagnostic" },
			{ "<leader>sp", ":lua vim.diagnostic.goto_previous()<CR>", desc = "Previous Diagnostic" },
			{ "<leader>sD", ":lua vim.lsp.buf.declaration()<CR>", desc = "Go to Declaration" },
			{ "<leader>sd", ":lua require('telescope.builtin').lsp_definitions()<CR>", desc = "Go to Definition" },
			{
				"<leader>si",
				":lua require('telescope.builtin').lsp_implementations()<CR>",
				desc = "Show Implementation",
			},
			{ "<leader>sH", ":lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help" },
			{ "<leader>sr", ":lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
			{ "<leader>sa", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
			{ "<leader>sR", ":lua require('telescope.builtin').lsp_references()<CR>", desc = "Show References" },
		},
}
