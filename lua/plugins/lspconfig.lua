return {
	{
		"mason-org/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			{
				"SmiteshP/nvim-navbuddy",
				dependencies = {
					"SmiteshP/nvim-navic",
					"MunifTanjim/nui.nvim",
				},
				opts = { lsp = { auto_attach = true } },
			},
		},
		opts = {
			diagnostics = { virtual_text = { prefix = "icons" } },
			servers = {
				clangd = {
					init_options = {
						compilationDatabasePath = "./",
					},
				},
				pyright = {},
				ts_ls = {},
				angularls = {},
				tailwindcss_language_server = {},
				emmet_language_server = {},
				powershell_editor_services = {},
				-- Simplified lua_ls config - lazydev handles the vim.* symbols
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							codeLens = {
								enable = true,
							},
							hint = {
								enable = true,
							},
						},
					},
				},
			},
		},
		event = "VeryLazy",
		config = function(_, opts)
			local signs = {
				Error = " ",
				Warn = " ",
				Hint = "󰌵 ",
				Info = " ",
			}

			local signConf = {
				text = {},
				texthl = {},
				numhl = {},
			}

			for type, icon in pairs(signs) do
				local severityName = string.upper(type)
				local severity = vim.diagnostic.severity[severityName]
				local hl = "DiagnosticSign" .. type
				signConf.text[severity] = icon
				signConf.texthl[severity] = hl
				signConf.numhl[severity] = hl
			end

			vim.diagnostic.config({
				signs = signConf,
			})

			for server, config in pairs(opts.servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
}
