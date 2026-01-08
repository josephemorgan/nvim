return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	opts = {
		debugger = {
			--name if netcoredbg is in PATH or full path like 'C:\Users\gusta\AppData\Local\nvim-data\mason\bin\netcoredbg.cmd'
			-- bin_path = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg.cmd",
		},
	},
}
