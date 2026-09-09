## Structure

- `init.lua` loads editor settings, early large-file detection, core mappings,
  terminal behavior, diagnostics, and the plugin manager.
- `lua/config/` contains editor configuration and larger plugin setup helpers.
- `lua/plugins/` contains Lazy specs grouped by feature. Keep a plugin's loading
  triggers, dependencies, options, and setup together in its spec. Lazy imports
  these files automatically; do not require plugin setup from `init.lua`.
- `after/ftplugin/` contains buffer-local language overrides. Autocommands here
  must be buffer-local and safe to register again.
- `lua/snip/go.lua` is a legacy custom snippet definition, currently not loaded.

## Loading

Options and large-file detection run first. The colorscheme, Treesitter, Snacks,
session handling, and LSP configuration remain available during startup. LSP
capability setup requires Blink, so Blink can load before its InsertEnter trigger.

Gitsigns and none-ls load on BufReadPre or BufNewFile. Treesitter context and color
highlighting load on BufReadPost or BufNewFile. Which-key and the statusline load
on VeryLazy; Alpha loads on VimEnter. LuaSnip loads on InsertEnter or Ctrl-K.

DAP, its UI, and the Go adapter load together on a debugging key or command.
NvimTree and Diffview load through their commands or mappings. Trouble, Grug Far,
and Kulala retain their command, key, or filetype triggers. Some other plugins
remain eager intentionally; there is no blanket lazy-loading default.

Use `:Lazy profile` to inspect loading. Track `lazy-lock.json` alongside the
configuration; `:Lazy restore` restores its recorded plugin revisions.

## Install language servers

Use `:Mason` to manage language servers and tools, and `:LspInfo` to inspect LSP.

## Dependencies

- Ag
- Rg
- Fzf

## Fonts

Font Patcher: https://github.com/ryanoasis/nerd-fonts/#font-patcher
