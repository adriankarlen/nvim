# nvim

Personal Neovim config. Requires Neovim **nightly** (uses the native
`vim.pack` package manager, no external plugin manager).

Normally consumed as a submodule of [adriankarlen/dots](https://github.com/adriankarlen/dots)
at `home/.config/nvim`, but works standalone too:

```sh
git clone https://github.com/adriankarlen/nvim.git ~/.config/nvim
```

## Layout

- `init.lua` — bootstraps `vim.pack`, shared helpers (`Config.now`/`Config.later`
  scheduling via `mini.misc`)
- `plugin/` — loaded in numeric order: options, mappings, `mini.nvim` modules,
  colorscheme (rose-pine), plugins (treesitter, lspconfig, snippets, ...),
  formatting, TypeScript project status
- `after/lsp/` — per-server LSP config (`cssls`, `emmylua_ls`, `roslyn_ls`, `vtsls`)
- `after/ftplugin/` — filetype-specific settings
- `snippets/` — LuaSnip-style snippets
