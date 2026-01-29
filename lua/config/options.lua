-- Editor options configuration
local M = {}

function M.setup()
	-- Folding
	vim.o.foldmethod = "expr"
	vim.o.foldexpr = "nvim_treesitter#foldexpr()"
	vim.o.foldenable = true
	vim.o.foldlevel = 4

	-- Search
	vim.opt.incsearch = true
	vim.opt.hlsearch = true

	-- Line numbers
	vim.opt.relativenumber = true
	vim.opt.number = true

	-- Appearance
	vim.opt.termguicolors = true
	vim.opt.background = "dark"
	vim.opt.ruler = true
	vim.opt.showmatch = true
	vim.opt.wrap = false

	-- Indentation
	vim.opt.expandtab = false
	vim.opt.tabstop = 2
	vim.opt.shiftwidth = 2
	vim.opt.formatoptions = "jcroql"

	-- Session
	vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	vim.o.exrc = true
end

return M
