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

" Telescope fuzzy finder 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

"  autopairs
Plug 'jiangmiao/auto-pairs'

" Parenthesising
Plug 'tpope/vim-surround'

" Javascript and TypeScript syntax highlight
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'

" Autocompletion
Plug 'neoclide/coc.nvim', { 'branch': 'release' } 

" Status menu
Plug 'vim-airline/vim-airline'

call plug#end()

colorscheme gruvbox

" FZf position
let g:fzf_layout = { 'down': '~40%' }

nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader><C-f>  :Files<CR>

" Telescope hot keys
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

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

" Coc tab actions
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>  pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
