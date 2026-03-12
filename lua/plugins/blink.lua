return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "super-tab" },
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
		sources = {
			-- default = { "lsp", "path", "snippets", "codecompanion" },
			default = function()
				local success, node = pcall(vim.treesitter.get_node)

				if
					success
					and node
					and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type())
				then
					return { "buffer", "codecompanion" }
				else
					return { "lazydev", "lsp", "path", "snippets", "codecompanion" }
				end
			end,
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				snippets = {
					opts = {
						friendly_snippets = true,
						extended_filetypes = {
							dart = { "flutter" },
							javascript = { "angular" },
							htmlangular = { "angular" },
						},
					},
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
}
