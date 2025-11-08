-- Angular requires a node_modules directory to probe for @angular/language-service and typescript
-- in order to use your projects configured versions.
local fs, fn, uv = vim.fs, vim.fn, vim.uv

local function collect_node_modules(root_dir)
	local results = {}

	local project_node = fs.joinpath(root_dir, "node_modules")
	if uv.fs_stat(project_node) then
		table.insert(results, project_node)
	end

	local ngserver_exe = fn.exepath("ngserver")
	if ngserver_exe and #ngserver_exe > 0 then
		local realpath = uv.fs_realpath(ngserver_exe) or ngserver_exe
		local candidate = fs.normalize(fs.joinpath(fs.dirname(realpath), "../../node_modules"))
		if uv.fs_stat(candidate) then
			table.insert(results, candidate)
		end
	end

	local internal_servers = fn.globpath(fn.stdpath("data"), "**/node_modules/.bin/ngserver", true, true)
	for _, exe in ipairs(internal_servers) do
		local realpath = uv.fs_realpath(exe) or exe
		local candidate = fs.normalize(fs.joinpath(fs.dirname(realpath), "../../node_modules"))
		if uv.fs_stat(candidate) then
			table.insert(results, candidate)
		end
	end

	return results
end

local function get_angular_core_version(root_dir)
	local package_json = fs.joinpath(root_dir, "package.json")
	if not uv.fs_stat(package_json) then
		return ""
	end

	local ok, f = pcall(io.open, package_json, "r")
	if not ok or not f then
		return ""
	end

	local json = vim.json.decode(f:read("*a")) or {}
	f:close()

	local version = (json.dependencies or {})["@angular/core"] or ""
	return version:match("%d+%.%d+%.%d+") or ""
end

---@type vim.lsp.Config
local angularls_config = {
	cmd = function(dispatchers, config)
		local root_dir = config.root or fn.getcwd()
		local node_paths = collect_node_modules(root_dir)

		local cmd = {
			"ngserver",
			"--stdio",
			"--tsProbeLocations",
			table.concat(node_paths, ","),
			"--ngProbeLocations",
			table.concat(
				vim.iter(node_paths)
					:map(function(p)
						return fs.joinpath(p, "@angular/language-server/node_modules")
					end)
					:totable(),
				","
			),
			"--angularCoreVersion",
			get_angular_core_version(root_dir),
		}
		return vim.lsp.rpc.start(cmd, dispatchers)
	end,

	filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
	root_markers = { "angular.json", "nx.json" },
}
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
				angularls = angularls_config,
				tailwindcss_language_server = {},
				emmet_language_server = {},
				powershell_editor_services = {},
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
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
}
