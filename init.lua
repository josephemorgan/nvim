vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

if vim.g.neovide then
	require("neovide").setup()
else
	-- Set transparent background for terminal
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

vim.opt.termguicolors = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.background = "dark"
vim.opt.ruler = true
vim.opt.showmatch = true
vim.opt.foldmethod = "syntax"
vim.opt.foldnestmax = 1
vim.opt.foldlevel = 1
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.formatoptions = "jcroql"
vim.opt.wrap = false
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.o.exrc = true

if vim.loop.os_uname().version:match("Windows") then
	vim.opt.shell = "pwsh.exe"
	vim.opt.shellcmdflag =
		"-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';$PSStyle.OutputRendering='plaintext';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
	vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
end

vim.cmd("colorscheme kanagawa-dragon")

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "csharp",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd("DirChanged", {
	callback = function(args)
		local new_dir = args.file
		local exrc_path = new_dir .. "/.nvim.lua"
		if vim.fn.filereadable(exrc_path) == 1 then
			vim.cmd("source " .. vim.fn.fnameescape(exrc_path))
		end
	end,
	desc = "Source .nvim.lua when changing working directory",
})

function _G.print_table(tbl, indent)
	indent = indent or 0
	local formatting = string.rep("  ", indent)
	if type(tbl) ~= "table" then
		print(formatting .. tostring(tbl))
		return
	end
	print(formatting .. "{")
	for k, v in pairs(tbl) do
		local key = tostring(k)
		if type(v) == "table" then
			io.write(formatting .. "  " .. key .. " = ")
			print_table(v, indent + 1)
		else
			print(formatting .. "  " .. key .. " = " .. tostring(v))
		end
	end
	print(formatting .. "}")
end
