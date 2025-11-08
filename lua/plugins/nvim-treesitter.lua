local languages = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"javascript",
	"typescript",
	"html",
	"python",
	"diff",
	"markdown",
	"markdown_inline",
	"angular",
	"scss",
	"csharp",
	"dart",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		-- version = false,
		-- lazy = false,
		build = ":TSUpdate",
		-- opts = {},
		-- config = function(_, opts)
		-- 	require("nvim-treesitter").setup()
		--
		-- 	require("nvim-treesitter")
		-- 		.install()
		-- 		:wait(300000)
		--
		-- 	vim.api.nvim_create_autocmd("FileType", {
		-- 		pattern = allowed_fts,
		-- 		callback = function(args)
		-- 			if vim.api.nvim_buf_line_count(args.buf) > 10000 then
		-- 				return
		-- 			end
		--
		-- 			-- Prefer angular parser for Angular component templates when available
		-- 			if ensured["angular"] and args.file and args.file:match("%.component%.html$") then
		-- 				vim.treesitter.start(args.buf, "angular")
		-- 			else
		-- 				vim.treesitter.start(args.buf)
		-- 			end
		-- 		end,
		-- 	})
		--
		-- 	-- vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		-- 	-- 	pattern = { "*" },
		-- 	-- 	callback = function(args)
		-- 	-- 		if vim.api.nvim_buf_line_count(args.buf) > 10000 then
		-- 	-- 			return
		-- 	-- 		end
		-- 	--
		-- 	-- 		if args.file:match("%.component.html$") then
		-- 	-- 			-- vim.bo[args.buf].filetype = "angularhtml"
		-- 	-- 			vim.treesitter.start(nil, "angular")
		-- 	-- 		else
		-- 	-- 			vim.treesitter.start()
		-- 	-- 		end
		-- 	--
		-- 	-- 		-- if vim.treesitter and type(vim.treesitter.foldexpr) == "function" then
		-- 	-- 		-- 	vim.bo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		-- 	-- 		-- end
		-- 	--
		-- 	-- 		-- local ok, nvim_ts = pcall(require, "nvim-treesitter")
		-- 	-- 		-- if ok and type(nvim_ts.indentexpr) == "function" then
		-- 	-- 		-- 	vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		-- 	-- 		-- end
		-- 	-- 	end,
		-- 	-- })
		-- end,
	},
	{
		"MeanderingProgrammer/treesitter-modules.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		setup = function()
			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				pattern = { "*" },
				callback = function(args)
					if args.file:match("%.component.html$") then
						vim.bo[args.buf].filetype = "angularhtml"
					end
				end,
			})
		end,
		opts = {
			ensure_installed = languages,
			fold = { enable = true },
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = { enable = true },
		},
	},
}
