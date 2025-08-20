call plug#begin()

language en_US

Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Styling
Plug 'gruvbox-community/gruvbox'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Native lsp config
Plug 'folke/neodev.nvim'
Plug 'neovim/nvim-lspconfig' 
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'hrsh7th/cmp-buffer' 
Plug 'hrsh7th/cmp-path' 
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'L3MON4D3/LuaSnip' 
Plug 'rafamadriz/friendly-snippets'

" split join
Plug 'AndrewRadev/splitjoin.vim'

" Mark down
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }

" Schemastore
Plug 'b0o/schemastore.nvim'


" progress bars shit
Plug 'j-hui/fidget.nvim'

" Signature
Plug 'ray-x/lsp_signature.nvim'

" Chat gpt
Plug 'jackMort/ChatGPT.nvim'
Plug 'MunifTanjim/nui.nvim'

" Git
Plug 'tpope/vim-fugitive'

" Nerdtree
" Plug 'scrooloose/nerdtree'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

" Telescope fuzzy finder 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"  autopairs
Plug 'windwp/nvim-autopairs'

" comment plugin
Plug 'tpope/vim-commentary'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}

" Parenthesising
Plug 'tpope/vim-surround'

Plug 'lukas-reineke/indent-blankline.nvim'

" Status menu
Plug 'nvim-lualine/lualine.nvim'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context' 

" Prettier
Plug 'sbdchd/neoformat'

" Test
" Plug 'vim-test/vim-test'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-jest'
Plug 'olimorris/neotest-rspec'

Plug 'folke/trouble.nvim'

" Ruby stuff
Plug 'slim-template/vim-slim'
Plug 'tpope/vim-rails'


call plug#end()

" lua shit
lua require("init")

" FZf position
let g:fzf_layout = { 'down': '~40%' }

set background=dark
colorscheme gruvbox
syntax enable

" gruvbox stuff
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_transparent_bg=1


let $PATH = '~/.nvm/versions/node/v20.11.0/bin/neovim-node-host' . $PATH
" let g:node_host_prog = expand('~/.nvm/versions/node/v20.11.0/bin/neovim-node-host')
" let g:node_host_prog = '/usr/local/bin/neovim-node-host'

" Workaround for creating transparent bg
autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
            \ |    highlight LineNr     ctermbg=NONE guibg=NONE
            \ |    highlight SignColumn ctermbg=NONE guibg=NONE

" neoformat auto format
augroup fmt
    autocmd!
    autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup End

filetype plugin indent on

