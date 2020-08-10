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

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

" plugin ekliyoruz:
call plug#begin('~/.vim/plugged')
" Plug 'arcticicestudio/nord-vim'
Plug 'ap/vim-css-color'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()
" colorscheme nord
colorscheme solarized
let g:solarized_termtrans=1
let g:solarized_italic=1
let g:solarized_bold=1
