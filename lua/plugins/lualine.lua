local function dap_status()
	local ok, dap = pcall(require, "dap")
	if not ok then
		return ""
	end
	local sessions = dap.sessions()
	if not sessions or vim.tbl_isempty(sessions) then
		return ""
	end
	local current = dap.session()
	local name = (current and current.config and current.config.name) or "?"
	local count = vim.tbl_count(sessions)
	if count > 1 then
		return string.format(" %s [%d]", name, count)
	end
	return string.format(" %s", name)
end

-- Global indicator: how many listed buffers have unsaved changes (anywhere).
local function unsaved_buffers()
	local count = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buflisted and vim.bo[buf].modified then
			count = count + 1
		end
	end
	return count > 0 and ("● " .. count) or ""
end

-- Label a tab by the basename of its tab-local working directory (set via :tcd).
local function tab_cwd_label(_, tab)
	local cwd = vim.fn.getcwd(-1, tab.tabnr)
	local name = vim.fn.fnamemodify(cwd, ":t")
	if name == "" then -- drive root (e.g. C:\) -> fall back one level
		name = vim.fn.fnamemodify(cwd, ":h:t")
	end
	return name ~= "" and name or cwd
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		options = {
			globalstatus = false, -- laststatus = 2: per-window statuslines (bottom)
			always_show_tabline = true, -- global tabline always visible (sets showtabline=2)
			-- Clean statuslines for sidebar/utility windows (extensions ship with lualine):
			extensions = { "nvim-tree", "aerial", "trouble", "quickfix" },
		},

		-- Per-window statusline (bottom): buffer-specific info.
		sections = {
			lualine_a = { "mode" },
			-- filename in section b (high-priority/left): survives narrow-split truncation.
			lualine_b = { { "filename", path = 4, symbols = { modified = "●", readonly = " " } } },
			lualine_c = { "diagnostics", "diff" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		-- Inactive windows (small glance-at splits): keep it tiny so the name always fits.
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { { "filename", path = 0, symbols = { modified = "●" } } }, -- basename only
			lualine_x = { "diagnostics", "location" },
			lualine_y = {},
			lualine_z = {},
		},

		-- Global tabline (top): editor-wide info.
		tabline = {
			lualine_a = {
				{
					"tabs",
					mode = 2, -- tab number + custom label (mode ~= 0 so fmt applies)
					max_length = function()
						return vim.o.columns
					end,
					fmt = tab_cwd_label, -- label = tab-local cwd basename
					-- built-in per-tab "[+]" modified marker stays on (show_modified_status default true)
				},
			},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {
				{
					dap_status,
					cond = function()
						local ok, dap = pcall(require, "dap")
						return ok and not vim.tbl_isempty(dap.sessions())
					end,
				},
				"branch",
				unsaved_buffers,
			},
			lualine_y = {},
			lualine_z = {},
		},
	},
}
