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
				copilot = {
					cmd = { "copilot-language-server", "--stdio" },
					root_markers = { ".git" },
				},
				pyright = {},
				ts_ls = {},
				angularls = {
					cmd = function(dispatchers, config)
						local root_dir = (config and config.root_dir) or vim.fn.getcwd()
						local node_modules = vim.fs.joinpath(root_dir, "node_modules")
						local probe = vim.uv.fs_stat(node_modules) and node_modules or ""

						local angular_core_version = ""
						local pkg = vim.fs.joinpath(root_dir, "package.json")
						if vim.uv.fs_stat(pkg) then
							local ok, content = pcall(vim.fn.readblob, pkg)
							if ok and content then
								local json = vim.json.decode(content) or {}
								angular_core_version = ((json.dependencies or {})["@angular/core"] or (
									json.devDependencies or {}
								)["@angular/core"] or ""):match("%d+%.%d+%.%d+") or ""
							end
						end

						local cmd = {
							"ngserver",
							"--stdio",
							"--tsProbeLocations",
							probe,
							"--ngProbeLocations",
							probe,
							"--angularCoreVersion",
							angular_core_version,
						}

						return vim.lsp.rpc.start(cmd, dispatchers)
					end,
					-- Disable rename in .ts buffers — ts_ls handles it there.
					-- angularls keeps rename capability in htmlangular buffers.
					on_attach = function(client, bufnr)
						local ft = vim.bo[bufnr].filetype
						if ft == "typescript" or ft == "typescriptreact" then
							client.server_capabilities.renameProvider = false
						end
					end,
				},
				tailwindcss = {},
				emmet_language_server = {},
				-- Simplified lua_ls config - lazydev handles the vim.* symbols
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
								library = {
									-- See the configuration section for more details
									-- Load luvit types when the `vim.uv` word is found
									vim.env.VIMRUNTIME,
									{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
								},
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

			-- Set htmlangular filetype for HTML files in Angular projects so angularls
			-- provides template-aware completions and diagnostics (not just generic HTML).
			vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
				pattern = "*.html",
				callback = function(args)
					if vim.fs.root(args.buf, { "angular.json", "nx.json" }) then
						vim.bo[args.buf].filetype = "htmlangular"
					end
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

					if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
						vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

						vim.keymap.set(
							"i",
							"<C-F>",
							vim.lsp.inline_completion.get,
							{ desc = "LSP: accept inline completion", buffer = bufnr }
						)
						vim.keymap.set(
							"i",
							"<C-G>",
							vim.lsp.inline_completion.select,
							{ desc = "LSP: switch inline completion", buffer = bufnr }
						)
					end
				end,
			})
		end,
	},
}
