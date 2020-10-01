" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch

" Mouse scroll
set scrolloff=5

" Set Tab size (hope so)
set tabstop=2

" Syntax highlight
syntax on

" To be able to reach clipboard
set clipboard=unnamedplus

" Line numers on
set number

set ruler
set showcmd
set incsearch

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

" plugin ekliyoruz:
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'ap/vim-css-color'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/forest-night'
Plug 'preservim/nerdtree'
call plug#end()
" colorscheme nord
let g:solarized_termtrans=1
let g:solarized_italic=1
let g:solarized_bold=1
colorscheme solarized

autocmd vimenter * NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" " the configuration options should be placed before `colorscheme forest-night`
" set termguicolors
" let g:forest_night_enable_italic = 1
" let g:forest_night_disable_italic_comment = 1
" let g:forest_night_transparent_background=1
" colorscheme forest-night
