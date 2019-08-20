" vim config

" Initialize plugin system
call plug#begin('~/.vim/plugged')

" The NERD tree: file explorer
Plug 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

" vim-aireline: enhanced status bar
Plug 'vim-airline/vim-airline'
let g:airline_theme='dark'

" fzf
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'

call plug#end()


" Use Vim settings
set nocompatible

" Enable filetype setting
filetype plugin on
filetype indent on

" Enable highlight
syntax on

" No backup files with ~ suffix
set nobackup

" Use utf8 as default
set encoding=utf-8 " vim internal encoding
set fileencoding=utf-8 " new file encoding

" Get function usage help automatically
set showfulltag
" Show matching parentheses/brackets
set showmatch
" Show current vim mode
set showmode

" Set backgoud
set background=dark

" Allow backspacing over everything in insert mode
set bs=2
" Don't include character under cursor in selection
set selection=exclusive
" Use a scrollable menu for filename completions
set wildmenu
" Case-insensitive searching
set ignorecase

" Indentation
set et
set ts=2
set sw=2
set autoindent
set smartindent

" Show line numbers
"   F12 = turn on/off line numbers
map <F12> :set nu!<CR>

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50    " keep 50 lines of command line history
set ruler   " show the cursor position all the time
set showcmd   " display incomplete commands
set incsearch   " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

if has("gui_running")
  colorscheme evening
  :set guioptions-=m
  :set guioptions-=T
  :set guioptions-=r
  :set guioptions-=L
  if has("win32")
    set fileencodings=ucs-bom,utf-8,latin1
    set guifont=Consolas:h10:cANSI
  elseif has("mac")
    set guifont="SF Mono"
  else
    set guifont=Hack\ 10
  endif
endif
