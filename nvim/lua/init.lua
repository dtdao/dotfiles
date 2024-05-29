local set = vim.opt
vim.g.mapleader = " "

set.syntax = 'on'
set.filetype = 'off'

set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.autoindent = true
set.relativenumber = true
set.shiftwidth = 4
set.expandtab = true
set.swapfile = false
set.number = true
set.hlsearch = false
set.scrolloff = 8
set.cmdheight = 2
set.tabstop = 4
set.clipboard = 'unnamedplus'

require('neodev').setup({
   library = { plugins = { "neotest" }, types = true },
})

require("treesitter.treesitter")
require("nvimTree.nvimTree")
require("telescope.telescope")
require("mason").setup()
require("chatGPT.chatGPT")
require("lsp.lsp")
require("indentblankline.ibl")
require("keymaps.keymaps")
require('trouble.trouble')
require('neotest.neotest')

require("nvim-autopairs").setup()

vim.env.PATH = '~/.nvm/versions/node/v20.11.0/bin:' .. vim.env.PATH

-- progress bar shit
require("fidget").setup{}

vim.opt.list = true
vim.opt.listchars:append "eol:↴"

