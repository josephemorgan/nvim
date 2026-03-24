# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A personal Neovim configuration targeting Windows 11 (with cross-platform awareness). Uses lazy.nvim for plugin management and Lua for all configuration.

## Architecture

**Entry point:** `init.lua` sets leader key (`<Space>`), handles Neovide/VSCode early exits, then loads config modules in order:
1. `config/lazy` - bootstraps lazy.nvim, loads all plugins from `lua/plugins/`
2. `config/options` - editor settings (tabs=2 no-expand, treesitter folding, relative line numbers)
3. `config/autocmds` - filetype overrides (Python/C# use 4-space expand), `.nvim.lua` exrc on DirChanged
4. `config/shell` - sets pwsh as shell on Windows
5. `config/colorscheme` - transparent bg in terminal, Neovide font config
6. `config/ui` - custom `vim.ui.select` (Telescope dropdown) and `vim.ui.input` (floating window)

**Plugin specs:** Each file in `lua/plugins/` returns a lazy.nvim plugin spec table. Lazy auto-imports the entire directory.

**Keybindings:** `lua/keybinds/init.lua` returns a which-key spec table that requires modular keybind files from `lua/keybinds/modules/`. Modules cover: ai, buffers, angular, dap, git, lsp, search, tasks, trouble, ui.

**Overseer templates:** Custom task runner templates in `lua/overseer/template/user/`.

**Prompts:** Markdown prompt files in `prompts/` for CodeCompanion AI chat roles (Analyst, Architect, Engineer, Tutor).

## Key Design Patterns

- All config modules use the `local M = {} / function M.setup() / return M` pattern
- Plugin specs use lazy.nvim's `opts` table convention; `config` functions are used only when setup requires imperative logic
- LSP servers are configured via `vim.lsp.config()` + `vim.lsp.enable()` (Neovim 0.11+ native API), not lspconfig's `setup()` calls
- `dev.path` points to `X:/dev/nvim/` on Windows for local plugin development, with `fallback = true`
- Per-project config supported via `exrc = true` and the DirChanged autocmd that sources `.nvim.lua`

## Language Support

- **C#/.NET:** Roslyn LSP via roslyn.nvim (with full inlay hints, code lens, solution-wide diagnostics). easy-dotnet.nvim is present but currently commented out
- **TypeScript/Angular:** ts_ls, angularls, tailwindcss, emmet_language_server
- **Lua/Neovim:** lua_ls with lazydev.nvim for `vim.*` type completions integrated into blink.cmp
- **Flutter/Dart:** flutter-tools.nvim with DAP adapter
- **Python:** pyright
- **C/C++:** clangd

## AI Integration

CodeCompanion is the primary AI plugin, configured with:
- Claude Code CLI as the agent provider
- Copilot.lua for inline completions
- MCPHub extension for MCP server access
- Prompt library loaded from both `$CWD/.prompts` and `$NVIM_CONFIG/prompts`
- Rules loaded from `AGENTS.md` and `.github/copilot-instructions.md`

## Completion

blink.cmp with super-tab keymap preset. Sources include: lazydev (top priority), lsp, path, snippets, codecompanion. In comments, falls back to buffer + codecompanion only.

## Formatting/Indentation

- Default: tabs, width 2
- Python: spaces, width 4
- C#: spaces, width 4
