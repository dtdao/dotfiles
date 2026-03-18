# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles for macOS, centered around Neovim (primary editor), Tmux, Zsh, and AeroSpace (window manager). Dependencies managed via Homebrew (`Brewfile`).

## Installation

No install script — files are symlinked or copied manually to `$HOME`. Install Homebrew dependencies with:

```sh
brew bundle
```

Tmux plugins are managed via [tpm](https://github.com/tmux-plugins/tpm). After copying `.tmux.conf`, install plugins with `prefix + I` inside tmux.

Neovim plugins are managed via [vim-plug](https://github.com/junegunn/vim-plug). Open Neovim and run `:PlugInstall`.

## Neovim Architecture

Entry point: `nvim/init.vim` → sources `nvim/lua/init.lua`

All Lua config lives in `nvim/lua/`, organized by feature:

| Module | File | Purpose |
|---|---|---|
| Core options | `lua/init.lua` | vim options, leader key (Space), requires all modules |
| Keymaps | `lua/keymaps/keymaps.lua` | All custom keybindings |
| LSP | `lua/lsp/lsp.lua` | Mason + lspconfig for Go, TS, Rust, Ruby, Lua |
| Treesitter | `lua/treesitter/treesitter.lua` | Syntax highlighting |
| Telescope | `lua/telescope/telescope.lua` | Fuzzy finder |
| File tree | `lua/nvimTree/nvimTree.lua` | nvim-tree config |
| Tests | `lua/neotest/neotest.lua` | neotest with jest + rspec adapters |
| Diagnostics | `lua/trouble/trouble.lua` | trouble.nvim keybindings |
| Indent guides | `lua/indentblankline/ibl.lua` | indent-blankline |

### Key conventions

- Tab width: 4 spaces, expandtab
- Auto-format on save via `neoformat`
- Clipboard: `unnamedplus` (system clipboard)
- Colorscheme: gruvbox (nvim) / catppuccin mocha (tmux)

### Important keybindings (for reference when editing configs)

- `<leader>` = Space
- `<C-n>` — toggle file tree, `<leader>ff/fg/fb` — telescope find/grep/buffers
- `gd` / `gr` / `K` — LSP go-to-definition / references / hover
- `<leader>ca` / `<leader>r` — LSP code action / rename
- `<leader>tf` / `<leader>ts` — neotest run file / toggle summary
- `<C-j/k/l/h>` — navigate splits
