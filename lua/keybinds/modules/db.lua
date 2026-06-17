local function copy_sqlserver_result()
	local url = vim.b.db or vim.g.db
	if not url then
		vim.notify("No active DB connection", vim.log.levels.ERROR)
		return
	end

	local rest = url:match("^sqlserver://(.+)$") or url:match("^mssql://(.+)$")
	if not rest then
		vim.notify("Not a SQL Server connection: " .. url, vim.log.levels.ERROR)
		return
	end

	local user, pass, server, db
	local creds, host_part = rest:match("^([^@]+)@(.+)$")
	if creds then
		user, pass = creds:match("^([^:]+):(.*)$")
		server, db = host_part:match("^([^/]+)/(.+)$")
	else
		server, db = rest:match("^([^/]+)/(.+)$")
	end

	if not server or not db then
		vim.notify("Could not parse connection URL: " .. url, vim.log.levels.ERROR)
		return
	end

	vim.ui.input({ prompt = "Query: " }, function(query)
		if not query or query == "" then
			return
		end

		local args = { "sqlcmd", "-S", server, "-d", db }
		if user then
			vim.list_extend(args, { "-U", user, "-P", pass })
		else
			table.insert(args, "-E")
		end
		vim.list_extend(args, { "-Q", "SET NOCOUNT ON; " .. query, "-y", "0", "-W", "-h", "-1" })

		vim.system(args, { text = true }, function(result)
			vim.schedule(function()
				if result.code ~= 0 then
					vim.notify("sqlcmd error:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
					return
				end
				vim.fn.setreg("+", result.stdout)
				vim.notify(("Copied %d chars to clipboard"):format(#result.stdout))
			end)
		end)
	end)
end

return {
	"<leader>D",
	group = "[D]atabase",
	{ "<leader>Du", "<cmd>DBUIToggle<cr>", desc = "Toggle DB [u]I" },
	{ "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "[f]ind/attach DB buffer" },
	{ "<leader>Da", "<cmd>DBUIAddConnection<cr>", desc = "[a]dd connection" },
	{ "<leader>Dy", copy_sqlserver_result, desc = "[y]ank query result (full width)" },
	{ "<leader>DE", "<Plug>(DBUI_ExecuteQuery)", desc = "[E]xecute selection", mode = "v" },
}
