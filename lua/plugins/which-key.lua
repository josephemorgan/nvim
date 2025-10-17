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

			-- AI Code Companion
			{
				"<leader>c",
				group = "Code [c]ompanion",
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
					"<leader>ct",
					desc = "Toggle Copilot [t]rigger",
					function()
						require("copilot.suggestion").toggle_auto_trigger()
					end,
				},
				{
					"<leader>cc",
					"<cmd>CodeCompanionChat Toggle<cr>",
					desc = "[c]hat",
				},
				{
					"<leader>cn",
					"<cmd>CodeCompanionChat Add<cr>",
					desc = "[n]ew chat",
				},
				{
					"<leader>ca",
					function()
						require("codecompanion").actions({})
					end,
					desc = "[a]ctions",
				},
			},

			-- UI Toggles
			{
				"<leader>u",
				group = "[u]i",
				-- Set up in snacks.lua
				{
					"<leader>uh",
					function()
						require("snacks").notifier.show_history()
					end,
					desc = "Show Notification [h]istory",
				},
			},

			-- Pickers
			{
				"<leader>p",
				group = "[p]ick",
				-- { "<c-p>", function() require("telescope.builtin").find_files() end, desc = "Find files" },
				{
					"<c-p>",
					function()
						require("snacks").picker.files()
					end,
					desc = "Find files",
				},
				{
					"<leader>pe",
					function()
						require("snacks").picker.explorer()
					end,
					desc = "[e]xplorer",
				},
				{
					"<leader>pb",
					function()
						require("snacks").picker.buffers()
					end,
					desc = "List [b]uffers",
				},
				{
					"<leader>pd",
					function()
						require("snacks").bufdelete.delete()
					end,
					desc = "[d]elete buffer",
				},
				{
					"<leader>pt",
					function()
						require("snacks").picker()
					end,
					desc = "[t]elescope",
				},
				{
					"<leader>pp",
					function()
						require("telescope").extensions.project.project()
					end,
					desc = "[p]rojects",
				},
				{
					"<leader>pr",
					function()
						require("telescope").extensions.file_browser.file_browser()
					end,
					desc = "b[r]owse files",
				},
			},

			{
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
			},

			{
				"<leader>a",
				group = "[a]ngular",
				{
					"<leader>at",
					function()
						local file = vim.api.nvim_buf_get_name(0)
						local fname = vim.fn.fnamemodify(file, ":t")
						local base = fname:match("^(.*%.component)%..*$")
						if base then
							vim.notify("Opening template: " .. base .. ".html")
							local dir = vim.fn.fnamemodify(file, ":h")
							local template_path = dir .. "/" .. base .. ".html"
							vim.cmd("edit " .. vim.fn.fnameescape(template_path))
						end
					end,
					desc = "Angular Component [t]emplate File",
				},
				{
					"<leader>ac",
					function()
						local file = vim.api.nvim_buf_get_name(0)
						local fname = vim.fn.fnamemodify(file, ":t")
						local base = fname:match("^(.*%.component)%..*$")
						if base then
							vim.notify("Opening component file: " .. base .. ".ts", vim.log.levels.INFO)
							local dir = vim.fn.fnamemodify(file, ":h")
							local template_path = dir .. "/" .. base .. ".ts"
							vim.cmd("edit " .. vim.fn.fnameescape(template_path))
						end
					end,
					desc = "Angular Component [c]omponent File",
				},
				{
					"<leader>as",
					function()
						local file = vim.api.nvim_buf_get_name(0)
						local fname = vim.fn.fnamemodify(file, ":t")
						local base = fname:match("^(.*%.component)%..*$")
						if base then
							vim.notify("Opening style file: " .. base .. ".scss", vim.log.levels.INFO)
							local dir = vim.fn.fnamemodify(file, ":h")
							local template_path = dir .. "/" .. base .. ".scss"
							vim.cmd("edit " .. vim.fn.fnameescape(template_path))
						end
					end,
					desc = "Angular Component [s]tyle File",
				},
			},

			-- Git
			{
				"<leader>g",
				group = "[g]it",
				{
					"<leader>gg",
					function()
						require("neogit").open({ kind = "floating" })
					end,
					desc = "Open neo[g]it",
				},
				{ "<leader>gd", ":DiffviewOpen<cr>", desc = "Open [d]iffview" },
				{
					"<leader>gh",
					function()
						local filename = vim.api.nvim_buf_get_name(0)
						if filename ~= "" then
							vim.cmd("DiffviewFileHistory " .. vim.fn.fnameescape(filename))
						else
							vim.cmd("DiffviewFileHistory")
						end
					end,
					desc = "Open current file [h]istory",
				},

				{
					"<leader>gl",
					function()
						require("snacks").git.blame_line()
					end,
					desc = "[b]lame file",
				},
				{ "<leader>gb", ":Blame<cr>", desc = "[b]lame file" },
			},

			-- Buffer Editing
			{
				"<leader>b",
				group = "[b]uffer",
				{
					"<leader>bf",
					function()
						require("conform").format()
					end,
					desc = "Format [f]ile",
				},
				{
					"<leader>bF",
					function()
						vim.g.disable_autoformat = not vim.g.disable_autoformat
					end,
					desc = "Toggle auto[F]ormat on save",
				},
				{
					"<leader>bs",
					function()
						require("snacks").scratch()
					end,
					desc = "Toggle [s]cratch buffer",
				},
				{
					"<leader>bS",
					function()
						require("snacks").scratch.select()
					end,
					desc = "[S]elect scratch buffer",
				},
				{
					"<leader>bd",
					function()
						require("snacks").bufdelete.delete()
					end,
					desc = "[d]elete buffer",
				},
			},

			-- Search
			{ "<leader>s", group = "[s]earch" },
			{
				"<leader>ss",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "[s]earch buffer",
			},
			{
				"<leader>sf",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "search [f]iles",
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

			-- Help
			{ "<leader>h", group = "[H]elp" },
			{
				"<leader>hh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Search [h]elp",
			},
			{
				"<leader>hm",
				function()
					require("telescope.builtin").man_pages()
				end,
				desc = "Search [m]anpages",
			},

			-- Tasks
			{ "<leader>t", group = "[t]asks" },
			{
				"<leader>tt",
				function()
					require("overseer").toggle()
				end,
				desc = "[t]oggle tasks",
			},
			{ "<leader>tr", "<cmd>OverseerRun<cr>", desc = "[r]un task" },
			{
				"<leader>tl",
				function()
					require("overseer").load_template()
				end,
				desc = "[l]oad task template",
			},

			-- LSP
			{ "<leader>l", group = "[L]anguage Server" },
			{
				"<leader>ld",
				function()
					vim.diagnostic.open_float()
				end,
				desc = "Open [d]iagnostics",
			},
			{
				"<leader>ls",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "Document [s]ymbols",
			},
			{
				"<leader>ll",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "[l]ist Diagnostics",
			},
			{
				"<leader>lh",
				function()
					vim.lsp.buf.signature_help()
				end,
				desc = "Signature [h]elp",
			},
			{
				"<leader>lr",
				function()
					vim.lsp.buf.rename()
				end,
				desc = "[r]ename",
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
					require("telescope.builtin").lsp_references()
				end,
				desc = "Show [R]eferences",
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
				{ "<leader>lg", group = "[g]o to" },
				{
					"<leader>lgd",
					function()
						require("telescope.builtin").lsp_definitions()
					end,
					desc = "[d]efinitions",
				},
				{
					"<f12>",
					function()
						require("telescope.builtin").lsp_definitions()
					end,
					desc = "[d]efinitions",
				},
				{
					"<leader>lgr",
					function()
						require("telescope.builtin").lsp_references()
					end,
					desc = "[r]references",
				},
				{
					"<S-f12>",
					function()
						require("telescope.builtin").lsp_references()
					end,
					desc = "[r]eferences",
				},
				{
					"<leader>lgi",
					function()
						require("telescope.builtin").lsp_implementations()
					end,
					desc = "[i]mplementations",
				},
			},

			-- DAP
			{
				{ "<leader>d", group = "[d]ebug" },
				{
					"<f5>",
					function()
						require("dap").continue()
					end,
					desc = "[c]ontinue (or start)",
				},
				{
					"<f10>",
					function()
						require("dap").step_over()
					end,
					desc = "Step [o]ver",
				},
				{
					"<f11>",
					function()
						require("dap").step_into()
					end,
					desc = "Step [i]nto",
				},
				{
					"<S-<f11>>",
					function()
						require("dap").step_out()
					end,
					desc = "Step [O]ut",
				},
				{
					"<f9>",
					function()
						require("dap").toggle_breakpoint()
					end,
					desc = "Toggle [b]reakpoint",
				},
				{
					"<leader>du",
					function()
						require("dap").up()
					end,
					desc = "Go [u]p",
				},
				{
					"<leader>dd",
					function()
						require("dap").down()
					end,
					desc = "Go [d]own",
				},
				{
					"<leader>dr",
					function()
						require("dap").repl.open()
					end,
					desc = "Open [r]EPL",
				},
				{
					"<leader>dR",
					function()
						require("dap").restart()
					end,
					desc = "[R]estart",
				},
				{
					"<leader>dh",
					function()
						require("dap.ui.widgets").hover()
					end,
					desc = "[h]over",
				},
				{
					"<leader>dp",
					function()
						require("dap.ui.widgets").preview()
					end,
					desc = "[p]review",
				},
				{ "<leader>dv", "<cmd>DapViewToggle<cr>", desc = "DAP [v]iew" },
				{
					"<leader>df",
					function()
						require("telescope").extensions.flutter.commands()
					end,
					desc = "[f]lutter commands",
				},
				{ "<leader>db", group = "[b]reakpoints" },
				{
					"<leader>dbl",
					function()
						require("dap").list_breakpoints()
					end,
					desc = "[l]ist",
				},
				{
					"<leader>dbc",
					function()
						require("dap").clear_breakpoints()
					end,
					desc = "[c]lear",
				},
				{
					"<leader>dbe",
					function()
						require("dap").set_exception_breakpoints()
					end,
					desc = "[e]xceptions",
				},
			},

			-- Folding
			{
				"<F19>",
				function()
					vim.cmd("normal! zo")
				end,
				desc = "Unfold once",
			},
			{
				"<S-F19>",
				function()
					vim.cmd("normal! zO")
				end,
				desc = "Unfold all",
			},
			{
				"<F16>",
				function()
					vim.cmd("normal! zc")
				end,
				desc = "Fold once",
			},
			{
				"<S-F16>",
				function()
					vim.cmd("normal! zC")
				end,
				desc = "FOld all",
			},
			{
				"zm",
				function()
					vim.cmd("normal! zM")
				end,
			},
			{
				"zM",
				function()
					vim.cmd("normal! zM")
				end,
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
