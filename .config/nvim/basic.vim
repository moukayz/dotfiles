""" set fzf vim auto completion
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

""" set custom leader
let mapleader="\\"

""" set nvim python provider
let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python_provider = 0

set clipboard+=unnamedplus
" always set vim-shell to bash (even use another shell, eg. fish)
set shell=/bin/bash 

" set true color
set termguicolors
set background=dark

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
augroup SetBashFileType
    autocmd!
    autocmd BufRead,BufNewFile,BufEnter .bash.* set filetype=sh
augroup END

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
set showmatch
set autoread
set list
set listchars=tab:›\ ,trail:⋅,space:⋅

""" Install plugins
" auto install vim-plug if it not installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
let plug_vim_path = data_dir . '/autoload/plug.vim'
if empty(glob(plug_vim_path))
    silent execute '!curl -fLko ' . plug_vim_path . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! if plug#begin()
    Plug 'junegunn/vim-plug'
    Plug 'christoomey/vim-tmux-navigator'

    " colorschemes
    Plug 'dracula/vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ayu-theme/ayu-vim'
    Plug 'sonph/onehalf', { 'rtp' : 'vim' }

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

    " Plug 'sheerun/vim-polyglot'
    " Plug 'vim-syntastic/syntastic'
    Plug 'plasticboy/vim-markdown'

    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " syntax (not need any more, use coc instead)
    " Plug 'ncm2/ncm2'
    " Plug 'roxma/nvim-yarp'

    " misc
    Plug 'easymotion/vim-easymotion'
    Plug 'vimwiki/vimwiki'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-unimpaired'

    " code completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " cheat.sh support for vim
    Plug 'dbeniamine/cheat.sh-vim'

    " languages
    Plug 'dag/vim-fish'

    "" vim ninja !!!!
    " Plug 'wikitopian/hardmode'

    call plug#end()

    " load configs for specified plugins
    source $VIM_PLUGIN_CONFIG_DIR/coc.vim
    source $VIM_PLUGIN_CONFIG_DIR/misc.vim
    source $VIM_PLUGIN_CONFIG_DIR/nerdtree.vim
    source $VIM_PLUGIN_CONFIG_DIR/fugitive.vim
    source $VIM_PLUGIN_CONFIG_DIR/gitgutter.vim
    source $VIM_PLUGIN_CONFIG_DIR/fzf.vim

    color onedark

endif


""""""""""""""""""""""""" colorful
syntax on
set noshowmode
" color onedark

" underline current line
" hi CursorLine cterm=underline gui=underline
