local t_builtin = require("telescope.builtin")
local t_themes = require("telescope.themes")
local snacks = require("snacks")

---@class PickerConfig
---@field default fun()
---@field buffers fun()
---@field lsp_symbols fun()
---@field workspace_lsp_symbols fun()
---@field lsp_references fun()
---@field lsp_definitions fun()
---@field lsp_type_definitions fun()
---@field lsp_implementations fun()
---@field diagnostics fun()
---@field pickers fun()
---@field lines fun()
---@field grep fun()
---@field registers fun()
---@field command_history fun()
---@field help fun()
---@field projects fun()
---@field git_history fun()
---@field resume fun()
---@field colorscheme fun()
---@field marks fun()
---@field explorer fun()

---@type PickerConfig
local snacks_config = {
	default = function()
		snacks.picker.smart()
	end,
	buffers = function()
		snacks.picker.buffers()
	end,
	lsp_symbols = function()
		snacks.picker.lsp_symbols()
	end,
	workspace_lsp_symbols = function()
		snacks.picker.lsp_workspace_symbols()
	end,
	lsp_references = function()
		snacks.picker.lsp_references()
	end,
	lsp_definitions = function()
		snacks.picker.lsp_definitions()
	end,
	lsp_type_definitions = function()
		snacks.picker.lsp_type_definitions()
	end,
	lsp_implementations = function()
		snacks.picker.lsp_implementations()
	end,
	diagnostics = function()
		snacks.picker.diagnostics()
	end,
	pickers = function()
		snacks.picker()
	end,
	lines = function()
		snacks.picker.lines()
	end,
	grep = function()
		snacks.picker.grep()
	end,
	registers = function()
		snacks.picker.registers()
	end,
	command_history = function()
		snacks.picker.command_history()
	end,
	help = function()
		snacks.picker.help()
	end,
	projects = function()
		snacks.picker.projects()
	end,
	git_history = function()
		snacks.picker.git_log_file()
	end,
	resume = function()
		snacks.picker.resume()
	end,
	colorscheme = function()
		snacks.picker.colorschemes()
	end,
	marks = function()
		snacks.picker.marks()
	end,
	explorer = function()
		snacks.picker.explorer()
	end,
}

---@type PickerConfig
local telescope_config = {
	default = function()
		t_builtin.find_files(t_themes.get_ivy())
	end,
	buffers = function()
		t_builtin.buffers(t_themes.get_ivy())
	end,
	lsp_symbols = function()
		t_builtin.lsp_document_symbols(t_themes.get_ivy())
	end,
	workspace_lsp_symbols = function()
		t_builtin.lsp_workspace_symbols(t_themes.get_ivy())
	end,
	lsp_references = function()
		t_builtin.lsp_references(t_themes.get_ivy())
	end,
	lsp_definitions = function()
		t_builtin.lsp_definitions(t_themes.get_ivy())
	end,
	lsp_type_definitions = function()
		t_builtin.lsp_type_definitions(t_themes.get_ivy())
	end,
	lsp_implementations = function()
		t_builtin.lsp_implementations(t_themes.get_ivy())
	end,
	diagnostics = function()
		t_builtin.diagnostics(t_themes.get_ivy())
	end,
	pickers = function()
		t_builtin.builtin(t_themes.get_dropdown())
	end,
	lines = function()
		t_builtin.current_buffer_fuzzy_find(t_themes.get_ivy())
	end,
	grep = function()
		t_builtin.live_grep(t_themes.get_ivy())
	end,
	registers = function()
		t_builtin.registers(t_themes.get_dropdown())
	end,
	command_history = function()
		t_builtin.command_history(t_themes.get_dropdown())
	end,
	help = function()
		t_builtin.help_tags(t_themes.get_dropdown())
	end,
	projects = function()
		require("telescope").extensions.project.project(t_themes.get_dropdown())
	end,
	git_history = function()
		t_builtin.git_bcommits(t_themes.get_ivy())
	end,
	resume = function()
		t_builtin.resume(t_themes.get_ivy())
	end,
	colorscheme = function()
		t_builtin.colorscheme(t_themes.get_ivy(), { enable_preview = true, ignore_builtins = true })
	end,
	marks = function()
		t_builtin.marks(t_themes.get_ivy())
	end,
	explorer = function()
		require("telescope").extensions.file_browser.file_browser({
			path = "%:p:h",
			select_buffer = true,
			grouped = true,
		})
	end,
}

---@type PickerConfig
return telescope_config
