" Input settings
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set shiftround
set infercase
set showmatch
set matchtime=3
set smartcase
set incsearch
set autoindent
set smartindent
set cindent
set whichwrap=b,s,h,l,<,>,[,]
set mouse=a
set wildmenu wildmode=list:longest,full

" Display settings
set number
set wrap
" set textwidth=80
set colorcolumn=81
set hlsearch
set ruler
set cmdheight=2
set laststatus=2
set scrolloff=8
set sidescrolloff=16
set sidescroll=1
set showcmd
set cursorline

set noswapfile
set statusline=%<%f\ %m%r%h%w%{'{'.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline+=%{fugitive#statusline()}
set title
set browsedir=buffer
set list
set listchars=tab:>\ ,extends:<

if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim/

if dein#load_state('~/.vim/repos/github.com/')
    call dein#begin('~/.vim/repos/github.com/')
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/neocomplete.vim')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('vim-scripts/Align')
    call dein#add('vim-scripts/surround.vim')
    call dein#add('Shougo/vimfiler.vim')
    call dein#add('vim-scripts/trailing-whitespace')
    call dein#add('vim-scripts/Cpp11-Syntax-Support')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tomtom/tcomment_vim')
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable
