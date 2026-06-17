local function open_sibling(ext, label)
	return function()
		local file = vim.api.nvim_buf_get_name(0)
		local base = vim.fn.fnamemodify(file, ":t"):match("^(.*%.component)%..*$")
		if not base then
			return
		end
		local target = vim.fn.fnamemodify(file, ":h") .. "/" .. base .. ext
		vim.notify("Opening " .. label .. ": " .. base .. ext, vim.log.levels.INFO)
		vim.cmd("edit " .. vim.fn.fnameescape(target))
	end
end

---@type LangModule
return {
	filetypes = { "typescript", "htmlangular", "html", "scss", "css" },
	detect = function(buf)
		return vim.fs.root(buf, { "angular.json", "nx.json" }) ~= nil
	end,
	spec = {
		"<leader>f",
		group = "Framework - Angular",
		{ "<leader>ft", open_sibling(".html", "template"), desc = "Component [t]emplate" },
		{ "<leader>fc", open_sibling(".ts", "component"), desc = "[c]omponent file" },
		{ "<leader>fs", open_sibling(".scss", "style"), desc = "[s]tyle file" },
	},
}
