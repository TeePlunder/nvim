# Neovim Config Audit — v0.12.1

**Date:** 2026-04-08
**Total startup:** ~163ms
**Plugin manager:** lazy.nvim
**Plugins:** 27 specs, ~42 including dependencies

---

## 1. Breaking Changes (0.10-0.12)

### `vim.loop` -> `vim.uv` (deprecated since 0.10, warns in 0.12)

| File | Line | Usage |
|------|------|-------|
| `lua/plugins/debugging.lua` | 80 | `vim.loop.fs_scandir(path)` |
| `lua/plugins/debugging.lua` | 84 | `vim.loop.fs_scandir_next(scan)` |
| `lua/config/lazy.lua` | 3 | `(vim.uv or vim.loop).fs_stat(lazypath)` — fallback unnecessary on 0.12 |

**Fix:** replace `vim.loop` with `vim.uv` everywhere. Drop the fallback in lazy.lua.

```lua
-- debugging.lua:80
local scan = vim.uv.fs_scandir(path)
-- debugging.lua:84
local name, t = vim.uv.fs_scandir_next(scan)
-- lazy.lua:3
if not vim.uv.fs_stat(lazypath) then
```

### No other 0.10-0.12 breakage found

- No `vim.diagnostic.disable()`/`is_disabled()` usage
- No legacy `sign_define()` for diagnostics
- No `vim.treesitter.get_parser()` pcall guards
- No `client.notify`/`client.request` dot-syntax
- No `vim.lsp.buf_get_clients` or `vim.lsp.get_active_clients`

---

## 2. Builtin Replacements

### nvim-lspconfig — still needed

Neovim 0.11+ ships `vim.lsp.config()` + `vim.lsp.enable()` but nvim-lspconfig still provides the server configuration registry (cmd, root_dir, settings per server). Migration is possible but not urgent — lspconfig works fine and upstream still recommends it for complex setups.

**Verdict:** keep. No action needed.

### nvim-cmp — still needed

Neovim 0.11 added `vim.lsp.completion.enable()` for basic completion, but it lacks snippet expansion, multiple sources, and the fuzzy matching nvim-cmp provides. Config uses LuaSnip + cmp-nvim-lsp + buffer sources.

**Verdict:** keep. Revisit when builtin completion matures (~0.13+).

### nvim-treesitter — markdown parser now bundled

Neovim 0.12 bundles markdown + markdown_inline parsers. The `ensure_installed` list in `lua/plugins/treesitter.lua:7` includes `"markdown"` which is redundant — treesitter will use the bundled parser anyway. Treesitter highlight/indent still adds value beyond the bundled parser, so keep the plugin.

**Fix (optional, cosmetic):** remove `"markdown"` from `ensure_installed`.

### renamer.nvim -> builtin `vim.lsp.buf.rename()`

`renamer.nvim` (filipdutescu/renamer.nvim) wraps LSP rename with a floating input. Neovim 0.10+ `vim.lsp.buf.rename()` now opens a floating prompt natively. The plugin is low-maintenance (last real commit ~2023) and adds a dependency for marginal UI benefit.

**Fix:** remove `lua/plugins/renamer.lua`. Add rename keymap to LSP attach:

```lua
-- in lsp-config.lua LspAttach callback
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename,
  vim.tbl_extend("force", opts, { desc = "Rename" }))
```

---

## 3. Plugin Hygiene

### neo-tree + oil — overlapping file browsers

Both load eagerly (no lazy trigger). Neo-tree is a tree sidebar; oil is a buffer-based directory editor. Both loading at startup is wasteful if only one is primary.

**Fix:** add lazy triggers to whichever is used less:
- neo-tree: `cmd = "Neotree"`, `keys = { "<leader>e" }`
- oil: add `keys = { "-", "<space>-" }` or `cmd = "Oil"`

### nvim-web-devicons — explicit setup unnecessary

Listed as a standalone plugin in `lua/plugins/nvim-web-devicons.lua` AND as a dependency of alpha, lualine, neo-tree, oil. The standalone spec with explicit `setup()` is redundant — dependencies handle loading. The `color_icons = true` and `default = true` opts are already the defaults.

**Fix:** delete `lua/plugins/nvim-web-devicons.lua`. Let it load as a dependency.

### marks.nvim — low value, unmaintained

Last significant commit ~2023. Neovim already shows marks in signcolumn with `vim.opt.signcolumn = "yes"` and you can navigate marks natively (`'a`, `` `a ``, etc.). The plugin adds gutter icons.

**Verdict:** optional removal. Low risk either way.

### Duplicate todo_comments keymap

`lua/plugins/todo_comments.lua` has `<leader>xt` mapped twice (identical command and desc).

**Fix:** remove the duplicate entry.

### telescope double-setup (BUG)

`telescope-ui-select.lua` calls `require("telescope").setup({...})` which **overwrites** the setup done in the main `telescope.lua`. This means the `defaults`, `pickers`, and `history` config from the main telescope spec are lost if ui-select loads second.

**Fix:** merge ui-select into the main telescope spec as a dependency + `load_extension` call:

```lua
-- In telescope.lua, add to dependencies:
"nvim-telescope/telescope-ui-select.nvim",

-- In telescope.lua config, after telescope.setup():
telescope.load_extension("ui-select")

-- Add to the setup extensions table:
extensions = {
  ["ui-select"] = {
    require("telescope.themes").get_dropdown({}),
  },
},

-- Then delete lua/plugins/telescope-ui-select.lua (currently a separate spec)
```

---

## 4. Startup Performance

### Measured top costs (self time)

| ms | Item |
|----|------|
| 36.9 | `require('config.lazy')` — lazy.nvim bootstrap + plugin scan |
| 4.5 | colorscheme sourcing (catppuccin) |
| 1.5 | ShaDa read |
| 1.0 | `require('oil')` |
| 0.8 | `require('neo-tree')` |
| 0.6 | `require('oil.config')` / `require('oil.ringbuf')` |
| 0.5 | `require('config.options')` |
| 0.4 | `require('config.keymaps')` |
| 0.3 | `require('luasnip.loaders.from_lua')` |
| 0.2 | `require('cmp_luasnip')` |

### Plugins loading eagerly that should be deferred

| Plugin | Current | Recommended lazy trigger | Est. savings |
|--------|---------|------------------------|-------------|
| mason.nvim | `lazy = false` | `cmd = "Mason"` or dependency-only | ~1ms |
| mason-lspconfig | `lazy = false` | dependency of nvim-lspconfig | ~1ms |
| neo-tree | no trigger | `cmd = "Neotree"`, `keys = {"<leader>e"}` | ~1ms |
| oil.nvim | no trigger | `keys = {"-", "<space>-"}` or `cmd = "Oil"` | ~2.6ms |
| alpha-nvim | no trigger | `event = "VimEnter"` | ~0.5ms |
| gitsigns.nvim | no trigger | `event = "BufReadPre"` | ~0.5ms |
| mini.indentscope | no trigger | `event = "BufReadPre"` | ~0.5ms |
| nvim-cmp | no trigger | `event = "InsertEnter"` | ~0.5ms |
| lualine.nvim | no trigger | `event = "VeryLazy"` | ~0.5ms |
| telescope.nvim | no trigger | `cmd = "Telescope"`, `keys` | ~1ms |

**Estimated total savings: ~8-10ms** (modest but adds up to ~5% improvement).

### No top-level require() issues

All startup requires are config initialization modules. Plugin specs are properly lazy-loaded via `{ import = "plugins" }`.

### No global variable leaks

All variables properly declared `local`.

---

## 5. Runtime Performance

### nvim-lint autocmd fires globally

`lua/plugins/lint.lua:12` — autocmd on `BufReadPost, BufWritePost, InsertLeave` with no buffer filter. `lint.try_lint()` checks `linters_by_ft` internally so it won't run eslint on non-JS files, but the autocmd callback still fires on every buffer for every event.

**Fix (optional):** not critical since `try_lint()` short-circuits. Could scope to specific filetypes for cleanliness:

```lua
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    lint.try_lint()
  end,
})
```

### No other runtime issues

- All `LspAttach` autocmds are buffer-scoped
- No expensive `CursorMoved`/`TextChanged` handlers
- No treesitter misconfigurations

---

## 6. Lua Quality

### `vim.cmd` string usage for colorscheme

| File | Line | Current | Idiomatic |
|------|------|---------|-----------|
| `init.lua` | 7 | `vim.cmd([[colorscheme catppuccin]])` | `vim.cmd.colorscheme("catppuccin")` |
| `auto-dark-mode.lua` | 6 | `vim.cmd("colorscheme catppuccin")` | `vim.cmd.colorscheme("catppuccin")` |
| `auto-dark-mode.lua` | 10 | `vim.cmd("colorscheme catppuccin")` | `vim.cmd.colorscheme("catppuccin")` |

Minor. Functional equivalent, structured form is more idiomatic.

### `vim.api.nvim_set_keymap` in neo-tree

`lua/plugins/neo-tree.lua` uses the old `vim.api.nvim_set_keymap` instead of `vim.keymap.set`. Not deprecated but the newer API is more idiomatic and supports lua function callbacks.

**Fix:**
```lua
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
```

### No missing pcall on optional requires

All `require()` calls are for hard dependencies. No issues.

---

## 7. Structure

### Empty autocmds.lua

`lua/config/autocmds.lua` is 0 bytes. The `require("config.autocmds")` in init.lua works (returns nil) but is dead weight.

**Fix:** either delete the file + remove the require, or move the lint autocmd here.

### Harpoon vs quickfix keymap conflict

| Keymap | keymaps.lua | harpoon.lua |
|--------|------------|-------------|
| `<leader>j` | `:lnext` (loclist next) | harpoon file 1 |
| `<leader>k` | `:lprev` (loclist prev) | harpoon file 2 |

Harpoon keys (lazy-loaded) override the global keymaps once harpoon loads. Loclist navigation only works before harpoon triggers.

**Decision needed:** keep one or remap the other.

---

## Implementation Priority

Create branch `nvim-audit` from `work` before changes.

### High (correctness)
1. Fix `vim.loop` -> `vim.uv` in `debugging.lua` and `lazy.lua`
2. Fix telescope double-setup — merge ui-select into main telescope spec
3. Remove duplicate `<leader>xt` in `todo_comments.lua`

### Medium (startup perf)
4. Lazy-load mason — `cmd = "Mason"` or dependency-only
5. Lazy-load neo-tree — `cmd = "Neotree"`, `keys = {"<leader>e"}`
6. Lazy-load oil — `keys = { "-", "<space>-" }`
7. Lazy-load gitsigns — `event = "BufReadPre"`
8. Lazy-load mini.indentscope — `event = "BufReadPre"`
9. Lazy-load nvim-cmp — `event = "InsertEnter"`
10. Lazy-load lualine — `event = "VeryLazy"`
11. Lazy-load telescope — `cmd = "Telescope"` + keys
12. Lazy-load alpha — `event = "VimEnter"`

### Low (cleanup)
13. Remove renamer.nvim, replace with `vim.lsp.buf.rename()` keymap
14. Delete nvim-web-devicons.lua standalone spec
15. Clean up empty autocmds.lua
16. `vim.cmd` -> `vim.cmd.colorscheme` in init.lua / auto-dark-mode
17. `nvim_set_keymap` -> `vim.keymap.set` in neo-tree
18. Scope nvim-lint autocmd to JS/TS filetypes

---

## Verification Checklist

After changes:
1. `nvim --startuptime /tmp/after.log -c 'qall'` — compare total to ~163ms baseline
2. Open a `.ts` file — confirm LSP attaches, completion works, eslint diagnostics appear
3. `<leader>cr` — confirm rename works (via builtin after renamer removal)
4. `<leader>e` — confirm neo-tree opens
5. `-` — confirm oil opens
6. `:Telescope find_files` — confirm telescope works with ui-select
7. `<leader>dc` — confirm DAP still works
8. `:checkhealth` — no warnings

---

## Resolved Questions

- neo-tree vs oil: **keep both** intentionally, lazy-load both
- `<leader>j`/`<leader>k`: **harpoon wins** — remove loclist mappings from keymaps.lua
- marks.nvim: **remove it**
- treesitter autoinstall=false / mason auto_install=true: **keep as-is** — treesitter has explicit ensure_installed, mason auto-install on demand is useful
