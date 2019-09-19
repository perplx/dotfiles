" vim config for an EMPTY config
" i.e. no assumptions made on the system defaults that this would 'override'
"
"      -Julien

" packages {{{

" run the following command to install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" run curl command to fetch vim-plug, then PlugInstall, automatically when first starting up
" see: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" call vim-plug
call plug#begin('~/.vim/plugged')

" colorschemes
"Plug 'sickill/vim-monokai'
"Plug 'nanotech/jellybeans.vim'

" plugins
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-syntastic/syntastic'
call plug#end()

" }}}

" defaults {{{

" default, syntax is off (?!?)
syntax on

" default, backspace is broken
"set backspace=2
set backspace=indent,eol,start

" use vim-defaults, not vi-defaults
if &compatible
	set nocompatible
endif

" }}}

" options {{{

" backups~
set backup
"set nobackup

" brackets
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " show matching bracket for 0.2 seconds
set matchpairs+=<:>     " specially for html

" buffer switching: <F5>+<number>
nnoremap <F5> :buffers<CR>:buffer<Space>

" colors
colorscheme elflord
"colorscheme jellybeans
"colorscheme monokai
"if &diff
"	colorscheme evening
"endif

" ex mode disabled
map Q <Nop>

" histories
set hidden              " remember undo after quitting

" indent: auto-indent based on file-type
filetype indent on
filetype plugin on

" scrolling
set scrolloff=2         " 2 lines above/below cursor when scrolling

" search
set hlsearch            " highlight matches
set incsearch           " incremental search
set ignorecase          " case-insensitive search...
set smartcase           " ...except when uppercase letters in search
set magic               " less backslashes in patterns

" tabs
set tabstop=4    " num spaces in a tab
set shiftwidth=4 " num spaces in an indent
"set expandtab    " tabs to spaces

" tabs: show characters
if !(&filetype == "txt")
	set list
	set listchars=tab:→\ ,trail:·
endif

" visual search
" visual select -> */# search for selection
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

" wildmenu
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn

" }}}

" filetypes {{{

" json: highlight .json files as .js files
" autocmd BufNewFile,BufRead *.json set ft=javascript

" python: indent with 4 spaces
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4

" vim: marker folding
autocmd FileType vim setlocal foldmethod=marker

" xml: indent with 2 spaces
autocmd FileType xml setlocal expandtab shiftwidth=2 tabstop=2

" }}}

" plugins {{{

" CtrlP

" CtrlP: <c-p> to invoke
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" NERDtree

" NERDtree: override netrw (should be default, isn't?)
let g:NERDTreeHijackNetrw=1

" NERDtree: quick toggle with <F9>
"map <silent> <F9>   :Explore<CR>
"map <silent> <S-F9> :sp +Explore<CR>
map <silent> <F9> :NERDTreeToggle<CR>

" signify

" signify: list of supported vcs systems
let g:signify_vcs_list = [ 'svn', 'git', 'hg' ]

" tagbar

" tagbar: quick toggle with <F8>
nmap <F8> :TagbarToggle<CR>

" tagbar: don't sort, keep in original order
let g:tagbar_sort = 0

" tagbar: set cursor-line in TagBar
" http://stackoverflow.com/questions/12649249/in-tagbar-plugin-in-vim-automatically-set-cursorline
autocmd FileType tagbar setlocal cursorline

" vim-airline

" vim-airline: powerline fonts
let g:airline_powerline_fonts = 1

" vim-airline: tabline
let g:airline#extensions#tabline#enabled = 1

" vim-ariline: there is a pause when leaving insert mode
set ttimeoutlen=50

" vim-airline: 256-color terminal yo
set t_Co=256

" vim-airline: doesn't appear until I create a new split
set laststatus=2

" vim-airline: How do i get rid of the default mode indicator?
set noshowmode

"" vim-solarized
"let g:solarized_termcolors=256
""if has('gui_running')
""    set background=light
""else
""    set background=dark
""endif
"colorscheme solarized

"" vim-monokai-refined (Sublime Text colors)
"set t_Co=256
"colorscheme Monokai-Refined

"" zenburn.vim
"set t_Co=256
"colorscheme zenburn

" }}}


" TESS

"set cursorbind
"set cursorcolumn
set cursorline

" split
set splitbelow
set splitright

" splits: navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" local vim config (not shared)
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
	source $LOCALFILE
endif
