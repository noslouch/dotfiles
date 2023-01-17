" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

colorscheme lucius
set t_Co=256

filetype off
execute pathogen#infect()
execute pathogen#helptags()
execute pathogen#incubate()
"
" Vundle Settings
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'https://github.com/gorodinskiy/vim-coloresque.git'

filetype plugin indent on
syntax on

au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.snip set syntax=ee

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

" CtrlP
let g:ctrlp_custom_ignore = {
    \ 'dir': '\v(\.git)|node_modules|bower_components|tmp|*?migrations?|CACHE|vendor|grappelli',
    \ 'file': '\.pyc$'
    \ }
" Matchit
nmap <Tab> %
vmap <Tab> %

" line numbers
autocmd FocusLost * :set number
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd CursorMoved * :set relativenumber

" hidden characters
set listchars=tab:▸\ ,eol:¬

" autosave
au FocusLost * :wa

" fold tags
nnoremap <leader>ft Vatzf

" quicker escaping
inoremap jj <ESC>

" splits and tabs
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>s <C-w>s<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" DelimitMate Options
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1
let g:delimitMate_jump_expansion = 1

" RubyTest Settings
let g:rubytest_spec_drb=1

" MiniBufferExplorer settings
map <leader>mbt :MBEToggle<CR>
map <leader>bd :MBEbd<CR>
noremap <leader>h <ESC>:bn<CR>
noremap <leader>g <ESC>:bp<CR>

" NERDTree settings
autocmd vimenter * if !argc() | NERDTree | endif
map <leader>a :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Tagbar Settings
let g:tagbar_usearrows = 1
nnoremap <leader>f :TagbarToggle<CR>

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

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

" Git conflict markers
" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
" nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

au BufRead,BufNewFile *.handlebars,*.hbs set ft=html syntax=handlebars
"let g:neomake_open_list = 2
" nnoremap <leader>o :lopen<cr>
" nnoremap <leader>c :lclose<cr>




" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")

    if exists(':Neomake')
        autocmd! BufWritePost,BufEnter * Neomake
    endif

    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css,scss setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                elseif getline(n) =~ '<%'
                    set ft=mako
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        autocmd BufNewFile,BufRead *.html,*.htm,*.j2 call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype html,htmldjango let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml source ~/.vim/bundle/closetag/closetag.vim
        autocmd filetype html,xhtml,xml imap </ <C-_>

    augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd filetype python setlocal textwidth=78
        autocmd filetype python match ErrorMsg '\%>120v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
"        autocmd filetype python noremap <buffer> <F5> :w<CR>:!python %<CR>
"        autocmd filetype python inoremap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
"        autocmd filetype python noremap <buffer> <S-F5> :w<CR>:!ipython %<CR>
"        autocmd filetype python inoremap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Automatic insertion of breakpoints
        autocmd filetype python nnoremap <buffer> <leader>bp :normal Oimport pdb; pdb.set_trace()<Esc>

        " Toggling True/False
        " autocmd filetype python nnoremap <silent> <C-t> mmviw:s/True\\|False/\={'True':'False','False':'True'}[submatch(0)]/<CR>`m:nohlsearch<CR>

        " Run a quick static syntax check every time we save a Python file
        " autocmd BufWritePost *.py call Flake8()
    augroup end " }}}

    augroup supervisord_files "{{{
        au!

        autocmd BufNewFile,BufRead supervisord.conf set ft=dosini
    augroup end " }}}

    augroup markdown_files "{{{
        au!

        autocmd filetype markdown noremap <buffer> <leader>p :w<CR>:!open -a Marked %<CR><CR>
    augroup end " }}}

    augroup ruby_files "{{{
        au!

        autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
        autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1 
        autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
        autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
        "
        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype ruby,eruby let b:closetag_html_style=1
        autocmd filetype ruby,eruby source ~/.vim/bundle/closetag/closetag.vim
        autocmd filetype ruby,eruby imap </ <C-_>
    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less,scss setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}

        " Toggling True/False
        " autocmd filetype javascript nnoremap <silent> <C-t> mmviw:s/true\\|false/\={'true':'false','false':'true'}[submatch(0)]/<CR>`m:nohlsearch<CR>
    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}

endif
" }}}


