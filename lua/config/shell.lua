-- Windows PowerShell shell configuration
local M = {}

function M.setup()
	if not vim.uv.os_uname().sysname:match("Windows") then
		return
	end

	vim.opt.shell = "pwsh"
	vim.o.shellcmdflag =
		"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
	vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end

return M
