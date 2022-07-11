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

" Git
Plug 'tpope/vim-fugitive'

" Nerdtree
Plug 'scrooloose/nerdtree'

" " Telescope fuzzy finder 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'fannheyward/telescope-coc.nvim'

"  autopairs
Plug 'jiangmiao/auto-pairs'

" " comment plugin
Plug 'tpope/vim-commentary'

" Parenthesising
Plug 'tpope/vim-surround'

" Javascript and TypeScript syntax highlight
" These are probably not needed because gruv can handle the syntax hightlight
" Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Autocompletion
Plug 'neoclide/coc.nvim', { 'branch': 'release' } 

" Status menu
Plug 'vim-airline/vim-airline'

" code snippets
" Plug 'L3MON4D3/LuaSnip'
" Plug 'rafamadriz/friendly-snippets'

" Prettier
Plug 'sbdchd/neoformat'
call plug#end()

" FZf position
let g:fzf_layout = { 'down': '~40%' }

nnoremap <Leader>gb :Git blame<CR>

" nerd tree keymaps
nnoremap <leader>n :NERDTreeFocus<cr>
nnoremap <C-n> :NERDTree<cr>
nnoremap <C-t> :NERDTreeToggle<cr>
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

" coc telesocpe 
lua require('telescope').load_extension('coc')
lua require('telescope').load_extension('fzy_native')

" GoTo code navigation. coc-vim
nmap <silent> gd <cmd> :Telescope coc definitions<cr>
nmap <silent> gr <cmd> :Telescope coc references<cr>
nmap <silent> gy <cmd> :Telescope coc implementations<cr>
nmap <silent> gi <cmd> :Telescope coc type_definitions<cr>

" Use c-space to trigger completion
if has("nvim")
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Coc autoimport
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Coc tab actions
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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


