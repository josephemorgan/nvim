local setupLspProgress = function()
	---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
	local progress = vim.defaulttable()
	vim.api.nvim_create_autocmd("LspProgress", {
		---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
			if not client or type(value) ~= "table" then
				return
			end
			local p = progress[client.id]

			for i = 1, #p + 1 do
				if i == #p + 1 or p[i].token == ev.data.params.token then
					p[i] = {
						token = ev.data.params.token,
						msg = ("[%3d%%] %s%s"):format(
							value.kind == "end" and 100 or value.percentage or 100,
							value.title or "",
							value.message and (" **%s**"):format(value.message) or ""
						),
						done = value.kind == "end",
					}
					break
				end
			end

			local msg = {} ---@type string[]
			progress[client.id] = vim.tbl_filter(function(v)
				return table.insert(msg, v.msg) or not v.done
			end, p)

			local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			vim.notify(table.concat(msg, "\n"), "info", {
				id = "lsp_progress",
				title = client.name,
				opts = function(notif)
					notif.icon = #progress[client.id] == 0 and " "
						or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
				end,
			})
		end,
	})
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		---@class snacks.zen.Config
		zen = {
			toggles = {
				dim = false,
				git_signs = false,
				mini_diff_signs = false,
				diagnostics = true,
			},
		},
		input = { enabled = false },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		---@class snacks.statuscolumn.Config
		statuscolumn = { enabled = false },
		toggle = { enabled = true },
		notifier = {
			enabled = true,
		},
		explorer = {
			replace_netrw = true,
		},
		-- picker = {
		-- 	sources = {
		-- 		explorer = {},
		-- 	},
		-- 	projects = {
		-- 		finder = "recent_projects",
		-- 		format = "file",
		-- 		-- dev = { "X:/dev/" },
		-- 	},
		-- },
		words = {
			enabled = true,
		},
		{
			"folke/edgy.nvim",
			---@module 'edgy'
			---@param opts Edgy.Config
			opts = function(_, opts)
				for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
					opts[pos] = opts[pos] or {}
					table.insert(opts[pos], {
						ft = "snacks_terminal",
						size = { height = 0.4 },
						title = "%{b:snacks_terminal.id}: %{b:term_title}",
						filter = function(_buf, win)
							return vim.w[win].snacks_win
								and vim.w[win].snacks_win.position == pos
								and vim.w[win].snacks_win.relative == "editor"
								and not vim.w[win].trouble_preview
						end,
					})
				end
			end,
		},
	},
	init = function()
		setupLspProgress()

		require("snacks").toggle.indent():map("<leader>ui")
		require("snacks").toggle.zen():map("<leader>ue")
		require("snacks").toggle.zoom():map("<leader>uz")
		require("snacks").toggle.dim():map("<leader>ud")
	end,
}
