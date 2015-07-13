set number
set expandtab
set shiftwidth=2
set softtabstop=2
set background=dark
set laststatus=2
set foldmethod=indent
set foldlevel=99
set incsearch
set hlsearch
set backspace=indent,eol,start
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype html setlocal ts=4 sts=4 sw=4
autocmd Filetype css setlocal ts=4 sts=4 sw=4
autocmd Filetype scss setlocal ts=4 sts=4 sw=4
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-haml'
Plugin 'Shougo/unite.vim'
Plugin 'bling/vim-airline'
Plugin 'noahfrederick/vim-hemisu'
Bundle 'morhetz/gruvbox'
Plugin 'w0ng/vim-hybrid'
Plugin 'rstacruz/sparkup' " HTML zen coding
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'jnurmine/Zenburn'
Plugin 'nanotech/jellybeans.vim'
Plugin 'skwp/vim-colors-solarized'
Plugin 'mattn/emmet-vim'
Plugin 'cdmedia/itg_flat_vim'
Plugin 'ajh17/Spacegray.vim'
Plugin 'danro/rename.vim'
Plugin 'slim-template/vim-slim.git'
Plugin 'kchmck/vim-coffee-script'
Plugin 'MaxSt/Flatcolor'
Plugin 'Valloric/YouCompleteMe'
Plugin 'godlygeek/csapprox'
Plugin 'romainl/Apprentice'
Plugin 'tomasr/molokai'
Plugin 'NLKNguyen/papercolor-theme'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Use this line with Vim 7.4 to auto indent html files
let g:html_indent_inctags = "html,body,head,tbody"
let g:hybrid_use_Xresources = 1
syntax on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" Remember to add these lines if you want to use solarized
" let g:solarized_termcolors=256
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
let g:gruvbox_contrast='hard'
let g:gruvbox_italic=1
colorscheme gruvbox
highlight Comment gui=italic cterm=italic
set background=dark
nmap <F8> :TagbarToggle<CR>

" Yanking and Pasting - Temporary solution
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <silent> y y:call ClipboardYank()<cr>
vnoremap <silent> d d:call ClipboardYank()<cr>
nnoremap <silent> p :call ClipboardPaste()<cr>p

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
