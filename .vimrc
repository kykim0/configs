

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Edit Operations  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Ctrl+d to backspace
map! <C-d> <Del>

" Shift+Enter to move cursor down
map <S-CR> <ESC>o
map! <S-CR> <ESC>o

" Complete parantheses
" map! () ()<ESC>i
" map! (); ();<ESC>hi
" map! [] []<ESC>i
" map! {} {}<ESC>i
" map! {}; {};<BS><ESC>i<CR><ESC>O<BS>
" map! <> <><ESC>i
" map! '' ''<ESC>i
" map! "" ""<ESC>i

" Recognize file type
filetype on

syntax on 

set nocompatible
set backspace=2
set autoindent
set cindent
set smartindent
set nowrap
set nowrapscan
set ignorecase
set incsearch
set nobackup
set ruler
set tabstop=2
set shiftwidth=2
set showcmd
set showmatch
set autowrite
set linespace=3
set title
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\
set tags+=./tags        " add current directory's generated tags file to available tags "
set expandtab


set number
set laststatus=2
set mouse+=a
set autoread            "auto reload files changed outside
set wildmenu
set wildmode=list:longest,full
colorscheme darkblue
