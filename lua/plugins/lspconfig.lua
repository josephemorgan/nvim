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
		"neovim/nvim-lspconfig",
		lazy = false,
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
				lua_ls = {
					on_init = function(client)
						if client.workspace_folders then
							local path = client.workspace_folders[1].name
							if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
								return
							end
						end

						client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
							runtime = {
								version = "LuaJIT",
							},
							-- Make the server aware of Neovim runtime files
							workspace = {
								checkThirdParty = true,
								library = {
									vim.env.VIMRUNTIME,
								},
							},
						})
					end,
					settings = {
						Lua = {},
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
				vim.lsp.enable(server)
				vim.lsp.config(server, require("blink.cmp").get_lsp_capabilities(config.capabilities))
			end
		end,
	},
}
