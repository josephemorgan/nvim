# LSP Configuration Notes

## Issue Resolved (2026-01-29)

**Problem:** `vim.*` symbols showed as undefined until `lspconfig.lua` was opened. Opening `init.lua` first caused warnings.

**Root Causes:**
1. `event = "VeryLazy"` delayed plugin loading until after first Lua file opened
2. Manual `on_init` workspace configuration was fragile and had timing issues

**Solution Applied:**
- Added `folke/lazydev.nvim` plugin with `ft = "lua"` for automatic Neovim Lua development support
- Simplified `lua_ls` configuration by removing manual `on_init` workspace setup
- `lazydev.nvim` automatically configures workspace libraries for vim.* symbols

**Config Location:** `lua/plugins/lspconfig.lua`

**Key plugins in LSP setup:**
- mason.nvim (with custom registries)
- lazydev.nvim (for Neovim Lua development)
- nvim-lspconfig (lazy = false)
- nvim-navbuddy (auto_attach enabled)

**Servers configured:**
- pyright, ts_ls, angularls, tailwindcss_language_server
- emmet_language_server, powershell_editor_services, lua_ls
