return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	---@class wk.Opts
	opts = {
		---@type false | "classic" | "modern" | "helix"
		preset = "modern",
		--- You can add any mappings here, or use `require('which-key').add()` later
		---@type wk.Spec
		spec = {
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

			-- UI Toggles
			{
				"<leader>u",
				group = "[u]i",
				-- Set up in snacks.lua
			},

			-- Pickers
			{
				"<leader>p",
				group = "[p]ick",
				{ "<c-p>", require("snacks").picker.files, desc = "Find files" },
				{ "<leader>pb", require("snacks").picker.buffers, desc = "List [b]uffers" },
				{ "<leader>pt", require("snacks").picker.pickers, desc = "picker" },
				{ "<leader>pp", require("snacks.picker").projects, desc = "[p]rojects" },
				{ "<leader>pr", require("telescope").extensions.file_browser.file_browser, desc = "b[r]owse files" },
				{ "<leader>pe", require("snacks").picker.explorer, desc = "[e]xplorer" },
			},

			-- Git
			{
				"<leader>G",
				group = "[G]it",
				{ "<leader>gg", require("neogit").open, desc = "Open neo[g]it" },
			},

			-- Buffer Editing
			{
				"<leader>b",
				group = "[b]uffer",
				{ "<leader>bf", require("conform").format, desc = "Format [f]ile" },
				{ "<leader>bd", require("snacks").bufdelete.delete, desc = "[d]elete buffer" },
			},

			-- Search
			{ "<leader>s", group = "[s]earch" },
			{ "<leader>ss", require("telescope.builtin").current_buffer_fuzzy_find, desc = "[s]earch buffer" },
			{ "<leader>sf", require("telescope.builtin").live_grep, desc = "search [f]iles" },
			{ "<leader>sb", "<cmd>BlameToggle<cr>", desc = "[b]lame" },

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
			{ "<leader>la", vim.lsp.buf.code_action, desc = "Code [a]ction" },
			{ "<leader>lR", require("telescope.builtin").lsp_references, desc = "Show [R]eferences" },
			{
				{ "<leader>lg", group = "[g]o to" },
				{
					"<leader>gn",
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
					"<leader>gp",
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
				{ "<leader>lgd", require("telescope.builtin").lsp_definitions, desc = "[D]efinitions" },
				{ "<f12>", require("telescope.builtin").lsp_definitions, desc = "[D]efinitions" },
				{ "<leader>lgi", require("telescope.builtin").lsp_implementations, desc = "[i]mplementations" },
				{ "<S-f12>", require("telescope.builtin").lsp_implementations, desc = "[i]mplementations" },
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
		},
		-- show a warning when issues were detected with your mappings
		-- Start hidden and wait for a key to be pressed before showing the popup
		-- Only used by enabled xo mapping modes.
		---@param ctx { mode: string, operator: string }
		defer = function(ctx)
			return ctx.mode == "V" or ctx.mode == "<C-V>"
		end,
		plugins = {
			marks = true, -- shows a list of your marks on ' and `
			registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
			spelling = {
				enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
				suggestions = 20, -- how many suggestions should be shown in the list?
			},
			presets = {
				operators = true, -- adds help for operators like d, y, ...
				motions = true, -- adds help for motions
				text_objects = true, -- help for text objects triggered after entering an operator
				windows = true, -- default bindings on <c-w>
				nav = true, -- misc bindings to work with windows
				z = true, -- bindings for folds, spelling and others prefixed with z
				g = true, -- bindings for prefixed with g
			},
		},
		---@type wk.Win.opts
		win = {
			-- don't allow the popup to overlap with the cursor
			no_overlap = true,
			-- width = 1,
			-- height = { min = 4, max = 25 },
			-- col = 0,
			-- row = math.huge,
			-- border = "none",
			padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
			title = true,
			title_pos = "center",
			zindex = 1000,
			-- Additional vim.wo and vim.bo options
			bo = {},
			wo = {
				-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
			},
		},
		layout = {
			width = { min = 20 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
		},
		keys = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		---@type (string|wk.Sorter)[]
		--- Mappings are sorted using configured sorters and natural sort of the keys
		--- Available sorters:
		--- * local: buffer-local mappings first
		--- * order: order of the items (Used by plugins like marks / registers)
		--- * group: groups last
		--- * alphanum: alpha-numerical first
		--- * mod: special modifier keys last
		--- * manual: the order the mappings were added
		--- * case: lower-case first
		sort = { "local", "order", "group", "alphanum", "mod" },
		---@type number|fun(node: wk.Node):boolean?
		expand = 0, -- expand groups when <= n mappings
		-- expand = function(node)
		--   return not node.desc -- expand all nodes without a description
		-- end,
		-- Functions/Lua Patterns for formatting the labels
		---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
		replace = {
			key = {
				function(key)
					return require("which-key.view").format(key)
				end,
				-- { "<Space>", "SPC" },
			},
			desc = {
				{ "<Plug>%(?(.*)%)?", "%1" },
				{ "^%+", "" },
				{ "<[cC]md>", "" },
				{ "<[cC][rR]>", "" },
				{ "<[sS]ilent>", "" },
				{ "^lua%s+", "" },
				{ "^call%s+", "" },
				{ "^:%s*", "" },
			},
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
			ellipsis = "…",
			-- set to false to disable all mapping icons,
			-- both those explicitly added in a mapping
			-- and those from rules
			mappings = true,
			--- See `lua/which-key/icons.lua` for more details
			--- Set to `false` to disable keymap icons from rules
			---@type wk.IconRule[]|false
			rules = {},
			-- use the highlights from mini.icons
			-- When `false`, it will use `WhichKeyIcon` instead
			colors = true,
			-- used by key format
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "󰘴 ",
				M = "󰘵 ",
				D = "󰘳 ",
				S = "󰘶 ",
				CR = "󰌑 ",
				Esc = "󱊷 ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "󰌑 ",
				BS = "󰁮",
				Space = "󱁐 ",
				Tab = "󰌒 ",
				F1 = "󱊫",
				F2 = "󱊬",
				F3 = "󱊭",
				F4 = "󱊮",
				F5 = "󱊯",
				F6 = "󱊰",
				F7 = "󱊱",
				F8 = "󱊲",
				F9 = "󱊳",
				F10 = "󱊴",
				F11 = "󱊵",
				F12 = "󱊶",
			},
		},
		show_help = true, -- show a help message in the command line for using WhichKey
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		-- disable WhichKey for certain buf types and file types.
		disable = {
			ft = {},
			bt = {},
		},
		debug = false, -- enable wk.log in the current directory
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = true })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
