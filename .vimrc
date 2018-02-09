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
set colorcolumn=80
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

" Do not store in buffer when deleted.
nnoremap x "_x
nnoremap dd "_dd

" Character code
set encoding=utf-8

" Yanks go into clipboard
set clipboard+=unnamed,autoselect

" Can select a block beyond eof in visual mode.
set virtualedit+=block

" =============================================================================
" Display color settings
" =============================================================================
":hi Comment ctermfg=Cyan

" Check if dein.vim is already installed
let dein_dir = $HOME . "/.vim/repos/github.com/Shougo/dein.vim"

if !isdirectory(dein_dir)
    let dein_url = "https://github.com/Shougo/dein.vim.git"
    echo printf("dein.vim not installed under %s", dein_dir)
    echo printf("Please run the following commands:"
    echo "curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh"
    echo "sh ./installer.sh ~/.vim"
    " Stop running script
    finish
endif

if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/repos/github.com/Shougo/dein.vim/

if dein#load_state('~/.vim/repos/github.com/')
    call dein#begin('~/.vim/repos/github.com/')
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/neocomplete.vim')
    call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('vim-scripts/Align')
    " Replace double quote with single quote, etc...
    call dein#add('vim-scripts/surround.vim')
    call dein#add('Shougo/vimfiler.vim')
    call dein#add('vim-scripts/trailing-whitespace')
    call dein#add('vim-scripts/Cpp11-Syntax-Support')
    " Execute git from vim
    call dein#add('tpope/vim-fugitive')
    " Comment out
    call dein#add('tomtom/tcomment_vim')
    call dein#add('nanotech/jellybeans.vim')
    call dein#add('tomasr/molokai')
    " Automatically insert the end of block
    call dein#add('tpope/vim-endwise')
    " Text manipulation (move, duplicate, ...)
    " call dein#add('t9md/vim-textmanip')
    call dein#add('vim-bracketed-paste')
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable

" =============================================================================
"                                   Colorscheme
" =============================================================================
" Installed in vim7 as default:
" - blue, darkblue, default, delek, desert, elford, evening, koehler,
"   morning, murphy, pablo, peachpuff, ron, shine, slate, torte, zellner
" Preferred settings:
" - deseert for remote connection
" =============================================================================
:colorscheme desert

" =============================================================================
"                             Key binds for GNU global
" =============================================================================
" Before using gtags, do 'gtags -v' under a root directory for a library, and
" create tag files.
" It is recommended to add GTAGS, GRTAGS, and GPATHS to .gitignore
" =============================================================================

" Close the current search result
nmap <C-q> <C-w><C-w><C-w>q
" Grep in the source code
nmap <C-g> :Gtags -g
" List all functions in the current file
nmap <C-l> :Gtags -f %<CR>
" Find the definition of the cursor position
nmap <C-j> :Gtags <C-r><C-w><CR>
" Find where the var/func the cursor is located at is used
nmap <C-k> :Gtags -r <C-r><C-w><CR>
" Jump to the next search result
nmap <C-n> :cn<CR>
" Jump to the previous search result
nmap <C-p> :cp<CR>

" =============================================================================
"                             Key binds for tComment
" =============================================================================
" <C-_><C-_>: comment out the selected part
" <C-_>n    : comment out with selected ft
" <C-_>s    : comment out with specified format
" <C-_>p    : comment out the whole block
" gcc       : = <C-_><C-_>

" Add comment styles to tComment
if !exists('g:tcomment_types')
    let g:tcomment_types = {}
endif
let g:tcomment_types = {
    \'cpp' : "// %s",
\}

" Add mapping
function! SetCppMapping()
    nmap <buffer> <C-_>c :TCommentAs cpp<CR>
    vmap <buffer> <C-_>c :TCommentAs cpp<CR>
endfunction

" Automatically open Quickfix-window after vimgrep
autocmd QuickFixCmdPost *grep* cwindow
