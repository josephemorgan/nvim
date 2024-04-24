return {
	setup = function()
		local wk = require("which-key")
		local telescope = require("telescope.builtin")

		vim.keymap.set("n", "<c-p>", telescope.find_files, { silent = true })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
		vim.keymap.set("n", "<f34>", telescope.buffers, { silent = true })

		wk.register({
			-- Files
			f = {
				name = "[f]iles",
				t = { require("nvim-tree.api").tree.open, "Toggle [t]ree" },
				g = { require("telescope.builtin").live_grep, "[g]rep File Contents" },
			},

			-- Help
			h = {
				name = "[h]elp",
				h = { require("telescope.builtin").help_tags, "Search [h]elp" },
				m = { require("telescope.builtin").man_pages, "Search [m]anpages" },
			},

			-- LSP
			l = {
				name = "[L]anguage Server",
				d = { vim.diagnostic.open_float, "Open [d]iagnostics" },
				s = { require("telescope.builtin").lsp_document_symbols, "Document [s]ymbols" },
				l = { require("telescope.builtin").diagnostics, "[l]ist Diagnostics" },
				h = { vim.lsp.buf.signature_help, "Signature [h]elp" },
				r = { vim.lsp.buf.rename, "[r]ename" },
				a = { vim.lsp.buf.code_action, "Code [a]ction" },
				R = { require("telescope.builtin").lsp_references, "Show [R]eferences" },
				g = {
					name = "[g]o to",
					p = { vim.diagnostic.goto_previous, "[p]revious Diagnostic" },
					n = { vim.diagnostic.goto_next, "[n]ext Diagnostic" },
					d = { vim.lsp.buf.declaration, "[d]eclaration" },
					D = { require("telescope.builtin").lsp_definitions, "[D]efinitions" },
					i = {
						require("telescope.builtin").lsp_implementations,
						"[i]mplementations",
					},
				},
			},

			-- DAP
			d = {
				name = "[d]ebug",
				c = { require("dap").continue, "[c]ontinue (or start)" },
				o = { require("dap").step_over, "Step [o]ver" },
				i = { require("dap").step_into, "Step [i]nto" },
				O = { require("dap").step_out, "Step [O]ut" },
				b = { require("dap").toggle_breakpoint, "Toggle [b]reakpoint" },
				B = { require("dap").set_breakpoint, "Set [B]reakpoint" },
				r = { require("dap").repl.open, "Open [r]EPL" },
				R = { require("dap").restart(), "[R]estart" },
				h = { require("dap.ui.widgets").hover, "[h]over" },
				p = { require("dap.ui.widgets").preview, "[p]review" },
				f = {
					function()
						local widgets = require("dap.ui.widgets")
						widgets.centered_float(widgets.frames)
					end,
					"[f]rames",
				},
				s = {
					function()
						local widgets = require("dap.ui.widgets")
						widgets.centered_float(widgets.scopes)
					end,
					"[s]copes",
				},
			},
		}, { prefix = "<leader>" })
	end,
}
