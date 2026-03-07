" -- .vimrc --
set nocompatible
set confirm
syntax on
set encoding=utf-8
set showmatch
set clipboard+=unnamedplus
colorscheme catppuccin

let &t_SI = "\<Esc>[6 q"
let &t_EI = "\<Esc>[2 q"

let &t_SR = "\<Esc>[4 q"


set number
set laststatus=2
set ruler
set wildmenu        " Turn on the wild menu
set cursorline      " Highlight cursorline
set so=15           " Set 15 lines to cursor

" -- Search --
set hlsearch
set ignorecase
set smartcase
set incsearch

"""" Tab settings

set tabstop=4           " width that a <TAB> character displays as
set expandtab           " convert <TAB> key-presses to spaces
set shiftwidth=4        " number of spaces to use for each step of (auto)indent
set softtabstop=4       " backspace after pressing <TAB> will remove up to this many spaces

set autoindent          " copy indent from current line when starting a new line
set smartindent         " even better autoindent (e.g. add indent after '{')


let mapleader = " "

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>e :Lexplore<CR>

inoremap jk <Esc>

nnoremap gy "+y
vnoremap gy "+y
nnoremap gp "+p

map <silent> <leader><cr> :nohl<CR>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
