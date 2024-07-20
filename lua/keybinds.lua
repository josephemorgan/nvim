return {
	setup = function()
		local wk = require("which-key")
		local telescope = require("telescope.builtin")

		vim.keymap.set("n", "<c-p>", telescope.find_files, { silent = true })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
		vim.keymap.set("n", "<f34>", telescope.buffers, { silent = true })

		wk.add({
			{ "gd", vim.lsp.buf.declaration, desc = "[d]eclaration" },
			{ "gD", require("telescope.builtin").lsp_definitions, desc = "[D]efinitions" },
			{ "gI", require("telescope.builtin").lsp_implementations, desc = "[i]mplementations" },
		})

		wk.add({
			-- Files
			{ "<leader>f", group = "[F]iles" },
            { "<leader>fg", require("telescope.builtin").live_grep, desc = "[g]rep File Contents" },
			{ "<leader>ft", require("nvim-tree.api").tree.open, desc = "Toggle [t]ree" },

			-- Help
			{ "<leader>h", group = "[H]elp" },
			{ "<leader>hh", require("telescope.builtin").help_tags, desc = "Search [h]elp" },
			{ "<leader>hm", require("telescope.builtin").man_pages, desc = "Search [m]anpages" },

			-- LSP
			{ "<leader>l", group = "[L]anguage Server" },
			{ "<leader>ld", vim.diagnostic.open_float, desc = "Open [d]iagnostics" },
			{ "<leader>ls", require("telescope.builtin").lsp_document_symbols, desc = "Document [s]ymbols" },
			{ "<leader>ll", require("telescope.builtin").diagnostics, desc = "[l]ist Diagnostics" },
			{ "<leader>lh", vim.lsp.buf.signature_help, desc = "Signature [h]elp" },
			{ "<leader>lr", vim.lsp.buf.rename, desc = "[r]ename" },
			{ "<leader>la", vim.lsp.buf.code_action, desc = "Code [a]ction" },
			{ "<leader>lR", require("telescope.builtin").lsp_references, desc = "Show [R]eferences" },
			{ "<leader>lp", vim.diagnostic.goto_previous, desc = "[p]revious Diagnostic" },
			{ "<leader>ln", vim.diagnostic.goto_next, desc = "[n]ext Diagnostic" },
			{
				{ "<leader>g", group = "[g]o to" },
				{ "<leader>gp", vim.diagnostic.goto_previous, desc = "[p]revious Diagnostic" },
				{ "<leader>gn", vim.diagnostic.goto_next, desc = "[n]ext Diagnostic" },
				{ "<leader>gd", vim.lsp.buf.declaration, desc = "[d]eclaration" },
				{ "<leader>gD", require("telescope.builtin").lsp_definitions, desc = "[D]efinitions" },
				{ "<leader>gi", require("telescope.builtin").lsp_implementations, desc = "[i]mplementations" },
			},

			-- DAP
			{
				{ "<leader>d", group = "[d]ebug" },
				{ "<leader>dc", require("dap").continue, desc = "[c]ontinue (or start)" },
				{ "<leader>do", require("dap").step_over, desc = "Step [o]ver" },
				{ "<leader>di", require("dap").step_into, desc = "Step [i]nto" },
				{ "<leader>dO", require("dap").step_out, desc = "Step [O]ut" },
				{ "<leader>db", require("dap").toggle_breakpoint, desc = "Toggle [b]reakpoint" },
				{ "<leader>dB", require("dap").set_breakpoint, desc = "Set [B]reakpoint" },
				{ "<leader>dr", require("dap").repl.open, desc = "Open [r]EPL" },
				{ "<leader>dR", require("dap").restart, desc = "[R]estart" },
				{ "<leader>dh", require("dap.ui.widgets").hover, desc = "[h]over" },
				{ "<leader>dp", require("dap.ui.widgets").preview, desc = "[p]review" },
				{
					"<leader>df",
					function()
						local widgets = require("dap.ui.widgets")
						widgets.centered_float(widgets.frames)
					end,
					desc = "[f]rames",
				},
				{
					"<leader>ds",
					function()
						local widgets = require("dap.ui.widgets")
						widgets.centered_float(widgets.scopes)
					end,
					desc = "[s]copes",
				},
			},
		})
	end,
}
