-- Platform-specific shell and job environment
local M = {}

-- Windows PowerShell shell configuration
local function setup_windows_shell()
	vim.opt.shell = "pwsh"
	vim.o.shellcmdflag =
		"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
	vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
	vim.o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end

-- A .NET SDK from dotnet-install.sh lives in ~/.dotnet and is only put on PATH by the login
-- shell, so a Neovide started from the desktop launcher would run the distro's older SDK.
-- Move it to the front of PATH (like `fish_add_path --move`) for tasks and Roslyn.
local function prefer_user_dotnet()
	local dotnet_root = vim.fn.expand("~/.dotnet")
	if vim.fn.executable(dotnet_root .. "/dotnet") == 0 then
		return
	end

	local tools = dotnet_root .. "/tools"
	local rest = vim.tbl_filter(function(dir)
		return dir ~= dotnet_root and dir ~= tools
	end, vim.split(vim.env.PATH or "", ":", { plain = true }))
	vim.env.PATH = table.concat(vim.list_extend({ dotnet_root, tools }, rest), ":")
	vim.env.DOTNET_ROOT = dotnet_root
end

function M.setup()
	if vim.uv.os_uname().sysname:match("Windows") then
		setup_windows_shell()
	else
		prefer_user_dotnet()
	end
end

return M
