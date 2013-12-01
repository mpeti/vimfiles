" Pathogen-nek sükséges beállíások {
" :call pathogen#helptags() "frissíti a help fájl indexet
  filetype off " 
  call pathogen#runtime_append_all_bundles() 
  filetype plugin indent on
" }

" Egyedi billentyűk {
imap jj <Esc> " ESC helyet jj is kilép insert módból
map <leader>c <c-_><c-_> " tComment plugin beállítások

nnoremap <silent> <F12> :bn<CR> " következő buffer
nnoremap <silent> <S-F12> :bp<CR> " előző buffer

nnoremap <silent> <S-F8> :bd!<C-M> " buffer törlése mentés nélkül
nnoremap <silent> <F8> bd<C-M> " buffer törlése

command Vimrc tabedit ~/.vimrc
autocmd bufwritepost .vimrc source ~/.vimrc

command! -nargs=* Wrap set wrap linebreak nolist

" }
" Basics {
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

 set nocompatible " explicitly get out of vi-compatible mode
 set noexrc " don't use local version of .(g)vimrc, .exrc
 set background=dark " we plan to use a dark background
 syntax on " syntax highlighting on
 set encoding=utf-8
 set textwidth=170
"}

"command Tidy set ft=html | execute "%!c:\tools\tidy.exe -q -i -html %"


" General {
 filetype plugin indent on " load filetype plugins/indent settings
 set autochdir " always switch to the current file directory
 set backspace=indent,eol,start " make backspace a more flexible
 set nobackup " make no backup files
 "set backupdir=~/.vim/backup " where to put backup files
 set fileformats=unix,dos,mac " support all three, in this order
 set mouse=a " use mouse everywhere
 set noerrorbells " don't make noise
 let mapleader = ","
" }

" Vim UI {
set gfn=DejaVu_Sans_Mono:h9:cEASTEUROPE

" columns	width of the display
 	set co=246
" lines	number of lines in the display
 	set lines=70
" window	number of lines to scroll for CTRL-F and CTRL-B
 	set window=69
" toolbar off
set guioptions-=T

colorscheme moria
"set cursorcolumn " highlight the current column
set cursorline " highlight current line
set laststatus=2 " always show the status line
set lazyredraw " do not redraw while running macros
set linespace=0 " don't insert any extra pixel lines betweens rows
set matchtime=5 " how many tenths of a second to blink matching brackets for
set incsearch " incremental searching
set hlsearch " keresés eredmény kijelölése
nnoremap <leader><space> :noh<cr> " és megszüntetése
set nostartofline " leave my cursor where it was
set novisualbell " don't blink
set number " turn on line numbers
set numberwidth=3 " We are good up tolines
set report=0 " tell us when anything is changed via :...
set ruler " Always show current positions along the bottom
set scrolloff=10 " Keeplines (top/bottom) for scope
nmap <leader>l :set list!<CR> " Shortcut to rapidly toggle `set list`
set listchars=tab:▸\ ,eol:¬ " Use the same symbols as TextMate for tabstops and EOLs
set showcmd " show the command being typed
set showmatch " show matching brackets
set sidescrolloff=10 " Keeplines at the size
"set statusline=%F%m%r%h%w[%L][%{strlen(&fenc)?&fenc:'none'}][%{&ff}]%y[%p%%][%04l,%04v]

"set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set statusline=%F
set statusline+=%m          "modified flag
set statusline+=%r          "read only flag
set statusline+=%h          "help file flag
set statusline+=%w
set statusline+=[%{strlen(&fenc)?&fenc:'none'}] "file encoding
set statusline+=[%{&ff}]    "file format (dos/unix/mac)
set statusline+=%y          "filetype
"set statusline+=[%p%%]      "percent through file
set statusline+=[line\ %l/%L,\ col\ %v] "line ##/max lines, col ##
" }

" }
 
" indent tabs {
set expandtab " no real tabs please!
set ignorecase " nem nagybetű érzékeny
set smartcase " kiváve ha nagybetős a kereési kulcsszó
set nowrap " do not wrap line
set shiftwidth=4 " auto-indent amount when using cindent
set softtabstop=4 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
set tabstop=8 " real tabs should be 8
" }

" Fájl típus függő beállítások {

" szöveg feldolgozást segítő fügvények
" dehyp -- sor végi kötöjelek eltávolítása - szó egyesítés
function! DeHyphen()
  normal gg0
  silent! %s/[^ ]\zs-\n\+\([^ ]\+\)\s/\1\r/g
  normal gg0
endfunction

command! DeHyp call DeHyphen()


" dehyp -- sor végi kötöjelek eltávolítása - szó egyesítés

" FixQuote -- idézőjelek javítása: 22h xxx 22h ==> 201eh xxx 201dh
function! FixQuote()
  normal gg0
  silent! %s/"\(\_.\{-}\)"/„\1”/g
  normal gg0
endfunction

command! FixQ call FixQuote()

" FixDash -- idézőjelek javítása: 2dh ==> 2012h 
function! FixDash()
  normal gg0
  silent! %s/ -,/ ‒,/g
  silent! %s/ -;/ ‒;/g
  silent! %s/ - / ‒ /g
  silent! %s/- /‒ /g
  " három pont: 2026h (ctrl-q u 2026)
  silent! %s/\.\.\./…/g
  normal gg0
endfunction

command! FixD call FixDash()

" SplitPar -- szöveg paragrafusokra bontása
function! SplitParFun(limit)
  execute '%!c:\perl\bin\perl.exe c:\tmp\splitpar.pl -'.a:limit
endfunction

command! -nargs=* SplitPar call SplitParFun(<f-args>)

" Markdown -- szöveg paragrafusokra bontása
function! MarkdownFun()
  execute '%!c:\tools\Markdown.pl'
endfunction

command! Markdown call MarkdownFun()


"Autohotkey from www.autohotkey.com
au BufNewFile,BufRead *.ahk setf ahk

"AutoIT
au BufNewFile,BufRead *.au3 setf autoit

" PHP
au BufNewFile,BufRead *.php,*.inc,*.phtml call DoPhpSettings()

function DoPhpSettings()
    set shiftwidth=4 " auto-indent amount when using cindent
    set softtabstop=4 " when hitting tab or backspace, how many spaces should a tab be (see expandtab)
    set tabstop=8 " real tabs should be 8
    map <F8> :!/usr/bin/ctags -R --php-kinds=+cf-v --totals=yes --tag-relative=yes .<CR>
endfunction

" EDI

au BufRead *.dat call DoEDISettings()

function DoEDISettings()
    let line1 = getline(1)
    if line1 =~ '^UNA:+.*'
        set filetype=edifact
    endif
    if line1 =~ '^SADK;.*'
        "set filetype=csv
        "let g:csv_delim=','
        "InitCSV
    endif
    if line1 =~ '^787|13|100|.*'
        set filetype=flat
    endif
endfunction
" }

"Underline current line using a function
"
"The following code (for your vimrc) defines a user command to underline the current line. Examples:
":Underline 	gives underlining like -------------- (default).
":Underline = 	gives underlining like ==============.
":Underline -= 	gives underlining like -=-=-=-=-=-=-=.

function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)


" Omni competetion {
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
"autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"autocmd FileType c set omnifunc=ccomplete#Complete

:set completeopt=longest,menuone
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" }
