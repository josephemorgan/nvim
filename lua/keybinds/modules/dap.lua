return {
	"<leader>d",
	group = "[d]ebug",
	{
		"<f5>",
		function()
			require("dap").continue()
		end,
		desc = "[c]ontinue (or start)",
	},
	{
		"<f10>",
		function()
			require("dap").step_over()
		end,
		desc = "Step [o]ver",
	},
	{
		"<f11>",
		function()
			require("dap").step_into()
		end,
		desc = "Step [i]nto",
	},
	{
		"<S-<f11>>",
		function()
			require("dap").step_out()
		end,
		desc = "Step [O]ut",
	},
	{
		"<f9>",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "Toggle [b]reakpoint",
	},
	{
		"<leader>du",
		function()
			require("dap").up()
		end,
		desc = "Go [u]p",
	},
	{
		"<leader>dd",
		function()
			require("dap").down()
		end,
		desc = "Go [d]own",
	},
	{
		"<leader>dr",
		function()
			require("dap").repl.open()
		end,
		desc = "Open [r]EPL",
	},
	{
		"<leader>dR",
		function()
			require("dap").restart()
		end,
		desc = "[R]estart",
	},
	{
		"<leader>dh",
		function()
			require("dap.ui.widgets").hover()
		end,
		desc = "[h]over",
	},
	{
		"<leader>dp",
		function()
			require("dap.ui.widgets").preview()
		end,
		desc = "[p]review",
	},
	{ "<leader>dv", "<cmd>DapViewToggle<cr>", desc = "DAP [v]iew" },
	{
		"<leader>df",
		function()
			require("telescope").extensions.flutter.commands()
		end,
		desc = "[f]lutter commands",
	},
	{
		"<leader>dw",
		function()
			vim.cmd("DapViewWatch")
		end,
		desc = "[w]atch expression",
	},
	{
		"<leader>dW",
		function()
			vim.ui.input({ prompt = "Watch expression: " }, function(input)
				if not input or input == "" then
					return
				end

				vim.cmd("DapViewWatch " .. input)
			end)
		end,
		desc = "Add [W]atch expression",
	},
	{ "<leader>db", group = "[b]reakpoints" },
	{
		"<leader>dbl",
		function()
			require("dap").list_breakpoints()
		end,
		desc = "[l]ist",
	},
	{
		"<leader>dbc",
		function()
			require("dap").clear_breakpoints()
		end,
		desc = "[c]lear",
	},
	{
		"<leader>dbe",
		function()
			require("dap").set_exception_breakpoints()
		end,
		desc = "[e]xceptions",
	},
}
