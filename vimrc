set number
set expandtab
set shiftwidth=2
set softtabstop=2
set laststatus=2
set foldmethod=indent
set foldlevel=99
set incsearch
set hlsearch
set backspace=indent,eol,start
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype go setlocal ts=8 sts=8 sw=8
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=4 sts=4 sw=4
autocmd Filetype scss setlocal ts=4 sts=4 sw=4
autocmd Filetype ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'Shougo/unite.vim'
Plugin 'bling/vim-airline'
Plugin 'noahfrederick/vim-hemisu'
Plugin 'morhetz/gruvbox'
Plugin 'w0ng/vim-hybrid'
Plugin 'rstacruz/sparkup' " HTML zen coding
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdcommenter'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'mattn/emmet-vim'
Plugin 'danro/rename.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'godlygeek/csapprox'
Plugin 'othree/html5.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'NSBrianWard/Glacier-Remixes'
Plugin 'chriskempson/base16-vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'derekwyatt/vim-scala'
Plugin 'dracula/vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'diepm/vim-rest-console'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" Use this line with Vim 7.4 to auto indent html files
let g:html_indent_inctags = "html,body,head,tbody"
let g:hybrid_use_Xresources = 1
syntax on
" Remember to add these lines if you want to use solarized
" let g:solarized_termcolors=256
set t_ZH=[3m
set t_ZR=[23m
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
set background=dark
colorscheme hybrid
let g:airline_theme='base16_eighties'
highlight Comment gui=italic cterm=italic
nmap <F8> :TagbarToggle<CR>

let mapleader = "\<Space>"

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

autocmd BufNew * wincmd l
autocmd vimenter * NERDTree | wincmd p
map <C-n> :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_new_tab=1
let g:nerdtree_tabs_open_on_console_startup=1

set undofile
set undodir=/Users/hailt/.vim/vimundo
set undolevels=1000
set undoreload=10000

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0

let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "!rspec {spec}"
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
