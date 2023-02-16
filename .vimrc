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

" leader key
let mapleader = " "

call plug#begin()

" Styling
Plug 'morhetz/gruvbox'

" Git
Plug 'tpope/vim-fugitive'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim' 

" autopairs
Plug 'jiangmiao/auto-pairs'

" Parenthesising
Plug 'tpope/vim-surround'

" Javascript and TypeScript syntax highlight
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'

" Autocompletion
Plug 'neoclide/coc.nvim', { 'branch': 'release' } 

" Plank line
Plug 'lukas-reineke/indent-blankline.nvim'

" Status menu
Plug 'vim-airline/vim-airline'

call plug#end()

colorscheme gruvbox

" FZf position
let g:fzf_layout = { 'down': '~40%' }

nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader><C-f>  :Files<CR>

" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" GoTo code navigation. coc-vim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Coc Autocompletion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"                              

" Coc tab actions
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
