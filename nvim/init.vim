set nocompatible
syntax on
filetype off

set ignorecase
set smartcase
set incsearch
set autoindent
set relativenumber
set noerrorbells
set belloff=all
set shiftwidth=4
set expandtab
set noswapfile
set number
set nohlsearch
set scrolloff=8
set cmdheight=2
set tabstop=4

" leader key
let mapleader = " "

call plug#begin()

Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }

" Styling
Plug 'gruvbox-community/gruvbox'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}

" Native lsp config
Plug 'neovim/nvim-lspconfig' 
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'hrsh7th/cmp-buffer' 
Plug 'hrsh7th/cmp-path' 
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'L3MON4D3/LuaSnip' 
Plug 'rafamadriz/friendly-snippets'

" Schemastore
Plug 'b0o/schemastore.nvim'

" Signature
Plug 'ray-x/lsp_signature.nvim'

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
Plug 'vim-test/vim-test'

call plug#end()

" lua shit
lua require("init")

" FZf position
let g:fzf_layout = { 'down': '~40%' }

nnoremap <Leader>gb :Git blame<CR>

" nerd tree keymaps
nnoremap <leader>n :NvimTreeFocus<cr>
nnoremap <C-n> :NvimTreeToggle<cr>
nnoremap <C-f> :NvimTreeFindFile<cr>
" let NERDTreeShowHidden=1

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Vim panel resize
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

set background=dark
colorscheme gruvbox
syntax enable

" gruvbox stuff
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_transparent_bg=1

" Workaround for creating transparent bg
autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
            \ |    highlight LineNr     ctermbg=NONE guibg=NONE
            \ |    highlight SignColumn ctermbg=NONE guibg=NONE

" neoformat auto format
augroup fmt
    autocmd!
    autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup End


