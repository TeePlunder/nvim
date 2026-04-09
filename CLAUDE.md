# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Bootstrap Flow

`init.lua` loads in order: `config/lazy.lua` (sets leader to space, bootstraps lazy.nvim) → `config/options.lua` → `config/keymaps.lua` → colorscheme. Leader must be set before keymaps load.

## Plugin Architecture

One file per plugin in `lua/plugins/`, auto-imported by lazy.nvim. Most plugins lazy-load via `event`, `cmd`, or `keys` triggers. Plugin-specific keymaps live in each plugin's spec (not in `config/keymaps.lua`). Buffer-local keymaps (LSP, gitsigns) are set in `on_attach`/`LspAttach` callbacks.

## LSP / Completion / Formatting / Linting Stack

These four systems are intentionally separated:

- **LSP** (`lsp-config.lua`): Mason auto-installs servers (lua_ls, gopls, ts_ls). Capabilities bridged to nvim-cmp via `cmp_nvim_lsp.default_capabilities()`. Keymaps registered on `LspAttach` autocmd.
- **Completion** (`completions.lua`): nvim-cmp with sources: LSP → LuaSnip → buffer. Trigger: Ctrl-Space.
- **Formatting** (`conform.lua`): Conform.nvim, runs on BufWritePre. prettier for JS/TS, stylua for Lua. TS LSP formatting is intentionally disabled — Conform handles it.
- **Linting** (`lint.lua`): nvim-lint with eslint_d for JS/TS files. Triggers on BufReadPost, BufWritePost, InsertLeave.

## Conventions

- **Theme:** catppuccin-macchiato, dark background
- **Indentation:** 2 spaces, no tabs
- **Keymaps:** every `vim.keymap.set` and `map()` call must include a `desc` field
- **Debugging** (`debugging.lua`): monorepo-aware — dynamically scans `apps/`/`libs/` dirs to create per-app DAP configs with Node.js js-debug adapter
