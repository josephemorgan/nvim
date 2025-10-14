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
		input = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		---@class snacks.statuscolumn.Config
		statuscolumn =
			---@field left snacks.statuscolumn.Components
			---@field right snacks.statuscolumn.Components
			---@field enabled? boolean
			{
				left = { "mark", "sign" }, -- priority of signs on the left (high to low)
				right = { "fold", "git" }, -- priority of signs on the right (high to low)
				folds = {
					open = false, -- show open fold icons
					git_hl = false, -- use Git Signs hl for fold icons
				},
				git = {
					-- patterns to match Git signs
					patterns = { "GitSign", "MiniDiffSign" },
				},
				refresh = 50, -- refresh at most every 50ms
			},
		toggle = { enabled = true },
		notifier = {
			enabled = true,
		},
		explorer = {
			replace_netrw = true,
		},
		picker = {
			sources = {
				explorer = {},
			},
			projects = {
				finder = "recent_projects",
				format = "file",
				dev = { "C:\\Users\\morganj\\dev\\" },
			},
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
