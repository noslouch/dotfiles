" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

colorscheme wombat256
set t_Co=256

filetype off
call pathogen#infect()
call pathogen#helptags()
call pathogen#incubate()
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
set undofile
set wrap                        " wrap lines
set showmatch                   " show matching closing tags
set virtualedit=all             " allow the cursor to go in to 'invalid' places
set showcmd		                " display incomplete commands
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to paste mode, wher eyou can pasete mass data that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator supports it
set fileformats="unix,dos,mac"  
set formatoptions+=1            " when wrapping paragraphs, don't end lines with 1-letter words (looks stupid)
set nrformats=                  " make <C-a> and <C-x> play well with zero-padded numbers (i.e. don't consider them octal or hex)
set nolist                      " don't show invisible characters by default, but turned on later for certain file types

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" tab settings
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set copyindent                  " copy previous line's indent
set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop

" searching and such
nnoremap / /\v
vnoremap / /\v
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set gdefault                    " search/replace globally on a line by default
set incsearch                   " show search matches as you type
set hlsearch                    " highlight search results
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

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

" select just pasted text for easy manipulation
nnoremap <leader>v V`]

" quicker escaping
inoremap jj <ESC>

" splits and tabs
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" C-a is used by tmux
":verbose map <C-a>
":nunmap <C-a>
":nnoremap <A-a> <C-a>
":nnoremap <A-x> <C-x>

" scratch buffer
" nnoremap <leader><tab> :Scratch<CR>

" syntastic settings
let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_mode_map = { 'mode' : 'active',
            \'active_filetypes': [], 
            \'passive_filetypes' : ['html'] }

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['sass']
let g:syntastic_php_checkers = ['php']
let g:syntastic_auto_loc_list=1
let g:syntastic_stl_format='[%E{Errors: %e | Line #%fe}%B{, }%W{Warnings: %w | Line #%fw}]'

set statusline=%#warningmsg#%{SyntasticStatuslineFlag()}%*  " syntastic status
set statusline+=bu:\ %-3.3n\                                " buffer number
set statusline+=\ %F\ :\                                    " full path
set statusline+=%y                                          " filetype
set statusline+=%m\ 
set statusline+=%=                                          " right align
set statusline+=%10((%l,%c)%)\                              " line number, column number

set autochdir "Set the current working dir to the open file
set nobackup

set history=50		" keep 50 lines of command line history

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

nnoremap <leader>q :call QuickFixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickFixToggle()
    if g:quickfix_is_open
        lclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        lopen
        let g:quickfix_is_open = 1
    endif
endfunction

" Quick yanking to end of line
nnoremap Y y$

" Quick alignment of text
nnoremap <leader>al :left<CR>
nnoremap <leader>ar :right<CR>
nnoremap <leader>ac :center<CR>

" Helpful use of space bar
nnoremap <space> :

" Quicksave
nnoremap <space><space> :w<cr>

" Git conflict markers
" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
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
        autocmd filetype python noremap <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python inoremap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python noremap <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python inoremap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Automatic insertion of breakpoints
        autocmd filetype python nnoremap <buffer> <leader>bp :normal Oimport pdb; pdb.set_trace()<Esc>

        " Toggling True/False
        autocmd filetype python nnoremap <silent> <C-t> mmviw:s/True\\|False/\={'True':'False','False':'True'}[submatch(0)]/<CR>`m:nohlsearch<CR>

        " Run a quick static syntax check every time we save a Python file
        autocmd BufWritePost *.py call Flake8()
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
        autocmd filetype javascript nnoremap <silent> <C-t> mmviw:s/true\\|false/\={'true':'false','false':'true'}[submatch(0)]/<CR>`m:nohlsearch<CR>
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


