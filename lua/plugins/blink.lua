return {
	"saghen/blink.cmp",
	dependencies = "rafamadriz/friendly-snippets",
	version = "*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' for mappings similar to built-in completion
		-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
		-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
		-- See the full "keymap" documentation for information on defining your own keymap.
		keymap = { preset = "enter" },
		appearance = {
			nerd_font_variant = "mono",
		},
		documentation = {
			auto_show = true,
			auto_show_delay = 500,
		},
		sources = {
			default = { "lsp", "path", "snippets", "codecompanion" },
			providers = {
				snippets = {
					should_show_items = function(ctx)
						return ctx.trigger.initial_kind ~= "trigger_character"
					end,
				},
			},
		},
		signature = {
			enabled = true,
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
