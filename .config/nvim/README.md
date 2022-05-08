## Lazy loading

- Note this setup is configured for lazy loading of plugins. Meaning plugins
  won't be used unless the filetype matches with settings in the
  `after/ftplugin` dir. It has its cons opening a `markdown` file and then
  `:e rustfile` won't enable lsp for rust file. To get around this put all
  null-ls config in `after/ftplugin/` config into `lua/_null-ls.lua` and require
  that in`init.lua`

## Install language servers

`:LspInstallInfo`

- `i` installs server
- `u` updates server
- `?` toggles commands

## Dependencies

- Ag
- Rg
- Fzf
