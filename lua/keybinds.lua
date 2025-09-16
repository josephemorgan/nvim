return {
	setup = function()
		local wk = require("which-key")
		local telescope = require("telescope.builtin")

		wk.add({
			-- Misc
			{ "K", vim.lsp.buf.hover, desc = "Show [K]ind" },
			{ "<leader>/", ":noh<CR>", desc = "Clear [s]earch" },

			-- LLM Code Companion
			{
				"<leader>c",
				group = "[c]ode companion",
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
					"<S-Right>",
					mode = { "i" },
					function()
						if require("copilot.suggestion").is_visible() then
							require("copilot.suggestion").accept_word()
						end
					end,
					desc = "Accept Copilot Suggestion Word",
				},
				{
					"<leader>cc",
					require("codecompanion").chat,
					desc = "[c]hat",
				},
				{
					"<leader>ca",
					require("codecompanion").actions,
					desc = "[a]ctions",
				},
				{
					"<leader>ct",
					desc = "Toggle Copilot [t]rigger",
					require("copilot.suggestion").toggle_auto_trigger,
				},
			},

			-- File Management
			{
				"<leader>p",
				group = "File Management",
				{ "<c-p>", telescope.find_files, desc = "Find files" },
				{ "<leader>pb", telescope.buffers, desc = "List [b]uffers" },
				{ "<leader>pd", require("snacks").bufdelete.delete, desc = "[d]elete buffer" },
				{ "<leader>pt", require("telescope.builtin").builtin, desc = "[t]elescope" },
				{ "<leader>pp", require("telescope").extensions.projects.projects, desc = "[p]rojects" },
				{ "<leader>pr", require("telescope").extensions.file_browser.file_browser, desc = "b[r]owse files" },
			},

			-- Git
			{
				"<leader>G",
				group = "[G]it",
				{ "<leader>gg", require("neogit").open, desc = "Open neo[g]it" },
			},

			-- Buffer Editing
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
				{ "<leader>dv", "<cmd>DapViewToggle<cr>", desc = "DAP [v]iew" },
				{ "<leader>df", require("telescope").extensions.flutter.commands, desc = "[f]lutter commands" },
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
