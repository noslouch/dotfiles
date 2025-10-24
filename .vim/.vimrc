" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

colorscheme lucius
set t_Co=256

filetype off

filetype plugin indent on
syntax on

let mapleader = ","
let maplocalleader = "\\"

" edit and reload ~/.vimrc for quick edits
nmap <silent> <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" sane defaults
set encoding=utf-8
set scrolloff=3                 " keep 3 lines off the edges of the screen when scrolling
set autoindent                  " autoindenting on
set showmode                    " show what mode we're in
set hidden
set wildmenu
set wildmode=list:longest
set title
set nomodeline                  " close security exploit
set visualbell
set cursorline
set ttyfast
set ruler                       " show the cursor position all the time
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set laststatus=2
set cmdheight=2
set relativenumber              " show line numbers relative to cursor position
" Disable temp and backup files for ember
set wildignore+=.*.swp,*~,._*
set nowrap                        " wrap lines
set showmatch                   " show matching closing tags
set virtualedit=all             " allow the cursor to go in to 'invalid' places
set showcmd                     " display incomplete commands
" set pastetoggle=<F2>            " when in insert mode, press <F2> to go to paste mode, wher eyou can pasete mass data that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator supports it
set fileformats="unix,dos,mac"
set formatoptions+=1            " when wrapping paragraphs, don't end lines with 1-letter words (looks stupid)
set nrformats=                  " make <C-a> and <C-x> play well with zero-padded numbers (i.e. don't consider them octal or hex)
set nolist                      " don't show invisible characters by default, but turned on later for certain file types

" undo settings
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set undodir=~/.vim/tmp/undo

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

set undofile                    " Undo history maintained across sessions
set undolevels=1000             " Save last 1000 changes
set undoreload=10000            " Load last 10,000 changes

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" tab settings
set tabstop=2                   " a tab is two spaces
set softtabstop=2               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=2                " number of spaces to use for autoindenting
set copyindent                  " copy previous line's indent
set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop

" searching and such
" nnoremap / /\v
" vnoremap / /\v
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set gdefault                    " search/replace globally on a line by default
set incsearch                   " show search matches as you type
set hlsearch                    " highlight search results
nnoremap <leader><space> :noh<cr>

" hidden characters
set listchars=tab:▸\ ,eol:¬

" quicker escaping
inoremap jj <ESC>

" splits and tabs
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set statusline+=bu:\ %-3.3n\                                " buffer number
set statusline+=\ %F\ :\                                    " full path
set statusline+=%y                                          " filetype
set statusline+=%m\
set statusline+=%=                                          " right align
set statusline+=%10((%l,%c)%)\                              " line number, column number

" set autochdir "Set the current working dir to the open file
set nobackup

set history=50      " keep 50 lines of command line history

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Quick yanking to end of line
nnoremap Y y$

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>
set clipboard=unnamed

" select just pasted text for easy manipulation
nnoremap <leader>v V`]

" Quick alignment of text
nnoremap <leader>al :left<CR>
nnoremap <leader>ar :right<CR>
nnoremap <leader>ac :center<CR>

" Quicksave
nnoremap <space><space> :w<cr>
