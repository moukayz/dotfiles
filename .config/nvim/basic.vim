""" set fzf vim auto completion
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

""" set custom leader
let mapleader="\\"

""" set nvim python provider
let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python_provider = 0

""" set true color
set termguicolors
set background=dark

""" Install plugins
call plug#begin()
" colorschemes
Plug 'dracula/vim'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline-themes'

" snippets
Plug 'honza/vim-snippets'

" tools
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'junegunn/vim-easy-align' " alianment operations
Plug 'tpope/vim-surround'      " surrounding operations
Plug 'preservim/nerdcommenter' " auto comment with shortcut
Plug 'justinmk/vim-sneak'      " quick search based on first two chars

" display
Plug 'machakann/vim-highlightedyank' " highlight yanked text
Plug 'junegunn/goyo.vim'             " concentrate only on text!
Plug 'junegunn/limelight.vim'        " highlight current paragraph
Plug 'junegunn/vim-emoji'            " get emoji from name
Plug 'ryanoasis/vim-devicons'        " awesome file icons
Plug 'vim-airline/vim-airline'       " just status line
Plug 'mhinz/vim-startify'            " vim startup page
Plug 'preservim/tagbar'              " show code structure by using ctags

" syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/rainbow_parentheses.vim'

Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'plasticboy/vim-markdown'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" git
Plug 'tpope/vim-fugitive'

" cpp
" Plug 'xavierd/clang_complete'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" misc
Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki'
Plug 'jiangmiao/auto-pairs'

" code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim ninjia !!!!
Plug 'wikitopian/hardmode'

call plug#end()

" map modification for init.vim
augroup ReloadVim
    autocmd!
    autocmd! BufWritePost ~/.config/nvim/**.vim source % | echom "Reloaded " . $MYVIMRC | redraw | e
augroup END

""" Enable syntax for CMakeLists.txt file
augroup CMakeSyntax
    autocmd!
    autocmd BufNewFile,BufRead CMakeLists.txt set filetype=cmake
augroup END

""" enable syntax for local bash config file
autocmd BufRead,BufNewFile,BufEnter .bash.* set filetype=sh

""" basic config
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd
set wrap breakindent " wrapped line has the same indent level with previous line
set encoding=utf-8   " use utf-8 encoding
set title            " display window title
set number           " enable line number
set relativenumber
set cursorline
set autoread

""""""""""""""""""""""""" colorful
syntax on
set noshowmode
" color onedark
color dracula
