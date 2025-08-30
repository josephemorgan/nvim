return {
	setup = function()
		local wk = require("which-key")
		local telescope = require("telescope.builtin")

		wk.add({
			-- Misc
			{ "K", vim.lsp.buf.hover, desc = "Show [K]ind" },
			{ "<leader>/", ":noh<CR>", desc = "Clear [s]earch" },

			-- Copilot
			{
				"<leader>c",
				group = "[c]opilot",
				{
					"<S-Tab>",
					mode = { "i" },
					function()
						if require("copilot.suggestion").is_visible() then
							require("copilot.suggestion").accept()
						end
					end,
					desc = "Accept Copilot Suggestion",
				},
				{
					"<leader>cc",
					function()
						require("CopilotChat").toggle({ window = { layout = "float" } })
					end,
					desc = "Copilot",
				},
				{
					"<leader>ct",
					desc = "Toggle Copilot [t]rigger",
					require("copilot.suggestion").toggle_auto_trigger,
				},
			},
			-- File Navigation
			{
				"<leader>p",
				group = "File [n]avigation",
				{ "<c-p>", telescope.find_files, desc = "Find files" },
				{ "<leader>pb", telescope.buffers, desc = "List [b]uffers" },
				{ "<leader>pt", require("telescope.builtin").builtin, desc = "[t]elescope" },
				{ "<leader>pp", require("telescope").extensions.projects.projects, desc = "[p]rojects" },
				{ "<leader>pr", require("telescope").extensions.file_browser.file_browser, desc = "b[r]owse files" },
				{ "<leader>pf", require("telescope").extensions.flutter.commands, desc = "[f]lutter commands" },
			},

			-- File Editing
			{
				"<leader>e",
				group = "[e]dit",
				{ "<leader>ef", require("conform").format, desc = "Format [f]ile" },
			},

			-- Search
			{ "<leader>s", group = "[s]earch" },
			{ "<leader>ss", require("telescope.builtin").current_buffer_fuzzy_find, desc = "[s]earch buffer" },
			{ "<leader>sf", require("telescope.builtin").live_grep, desc = "search [f]iles" },

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
			{ "<leader>jd", vim.lsp.buf.declaration, desc = "[d]eclaration" },
			{ "<leader>jD", require("telescope.builtin").lsp_definitions, desc = "[D]efinitions" },
			{ "<leader>jI", require("telescope.builtin").lsp_implementations, desc = "[i]mplementations" },
			{ "<leader>jt", require("flash").treesitter, desc = "Treesitter Jump" },

			-- Help
			{ "<leader>h", group = "[H]elp" },
			{ "<leader>hh", require("telescope.builtin").help_tags, desc = "Search [h]elp" },
			{ "<leader>hm", require("telescope.builtin").man_pages, desc = "Search [m]anpages" },

			-- Tasks
			{ "<leader>t", group = "[t]asks" },
			{ "<leader>tt", require("overseer").toggle, desc = "[t]oggle tasks" },
			{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "[r]un task" },
			{ "<leader>tl", require("overseer").load_template, desc = "[l]oad task template" },

			-- LSP
			{ "<leader>l", group = "[L]anguage Server" },
			{ "<leader>ld", vim.diagnostic.open_float, desc = "Open [d]iagnostics" },
			{ "<leader>ls", require("telescope.builtin").lsp_document_symbols, desc = "Document [s]ymbols" },
			{ "<leader>ll", require("telescope.builtin").diagnostics, desc = "[l]ist Diagnostics" },
			{ "<leader>lh", vim.lsp.buf.signature_help, desc = "Signature [h]elp" },
			{ "<leader>lr", vim.lsp.buf.rename, desc = "[r]ename" },
			{ "<C-.>", vim.lsp.buf.code_action, desc = "Code action" },
			{ "<leader>lR", require("telescope.builtin").lsp_references, desc = "Show [R]eferences" },
			{
				{ "<leader>g", group = "[g]o to" },
				{
					"<leader>gp",
					function()
						vim.diagnostic.jump({ count = -1, float = true })
					end,
					desc = "[p]revious Diagnostic",
				},
				{
					"<leader>gn",
					function()
						vim.diagnostic.jump({ count = 1, float = true })
					end,
					desc = "[n]ext Diagnostic",
				},
				{ "<leader>gd", require("telescope.builtin").lsp_definitions, desc = "[D]efinitions" },
				{ "<leader>gi", require("telescope.builtin").lsp_implementations, desc = "[i]mplementations" },
			},

			-- DAP
			{
				{ "<leader>d", group = "[d]ebug" },
				{
					"<f5>",
					require("dap").continue,
					desc = "[c]ontinue (or start)",
				},
				{
					"<f10>",
					require("dap").step_over,
					desc = "Step [o]ver",
				},
				{ "<f11>", require("dap").step_into, desc = "Step [i]nto" },
				{ "<S-<f11>>", require("dap").step_out, desc = "Step [O]ut" },
				{ "<f9>", require("dap").toggle_breakpoint, desc = "Toggle [b]reakpoint" },
				{ "<leader>du", require("dap").up, desc = "Go [u]p" },
				{ "<leader>dd", require("dap").down, desc = "Go [d]own" },
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
				{ "<leader>dv", "<cmd>DapViewToggle<cr>", desc = "DAP [v]iew" },
				{ "<leader>db", group = "[b]reakpoints" },
				{
					"<leader>dbl",
					require("dap").list_breakpoints,
					desc = "[l]ist",
				},
				{
					"<leader>dbc",
					require("dap").clear_breakpoints,
					desc = "[c]lear",
				},
				{
					"<leader>dbe",
					require("dap").set_exception_breakpoints,
					desc = "[e]xceptions",
				},
			},
		})
	end,
}
