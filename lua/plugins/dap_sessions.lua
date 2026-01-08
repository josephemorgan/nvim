return {
	"josephemorgan/dap_session_picker.nvim",
	dev = true,
	config = function()
		require("telescope").load_extension("session_picker")
	end,
}
