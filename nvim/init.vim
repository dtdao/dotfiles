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

" Schemastore
Plug 'b0o/schemastore.nvim'

" Signature
Plug 'ray-x/lsp_signature.nvim'

" Git
Plug 'tpope/vim-fugitive'

" Nerdtree
Plug 'scrooloose/nerdtree'

" Telescope fuzzy finder 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"  autopairs
Plug 'jiangmiao/auto-pairs'

" comment plugin
Plug 'tpope/vim-commentary'

" Parenthesising
Plug 'tpope/vim-surround'

" Status menu
Plug 'vim-airline/vim-airline'

" Tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Prettier
Plug 'sbdchd/neoformat'

call plug#end()

" lua shit
lua require("init")

lua require('telescope').load_extension('fzf')

" FZf position
let g:fzf_layout = { 'down': '~40%' }

nnoremap <Leader>gb :Git blame<CR>

" nerd tree keymaps
nnoremap <leader>n :NERDTreeFocus<cr>
" nnoremap <C-n> :NERDTree<cr>
nnoremap <C-n> :NERDTreeToggle<cr>
nnoremap <C-f> :NERDTreeFind<cr>
let NERDTreeShowHidden=1

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Vim panel resize
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>

" Telescope hot keys
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden = true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fr <cmd>lua require('telescope.builtin').resume()<cr>

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
    autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
    autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry
augroup End


