-- Leader must be set before lazy.nvim loads plugins
vim.g.mapleader = " "

-- Set guifont early so Neovide doesn't fall back to system defaults
if vim.g.neovide then
	vim.o.guifont = "FiraCode Nerd Font:h12"
end

-- Early exit for VSCode Neovim extension
if vim.g.vscode then
	return
end

-- Load configuration modules
require("config.lazy").setup() -- Plugin manager (must be first after leader)
require("config.options").setup() -- Editor options
require("config.autocmds").setup() -- Autocommands
require("config.shell").setup() -- Platform-specific shell
require("config.colorscheme").setup() -- Appearance
require("config.ui").setup() -- UI overrides
