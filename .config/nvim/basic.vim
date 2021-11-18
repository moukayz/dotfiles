""" set fzf vim auto completion
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

""" set custom leader
let mapleader="\\"

" in vim instead of nvim, and &term doesn't contain 'xterm'
" (eg. in tmux &term is `screen-256color`)
" need to set these options to enable `termguicolors`
if !has('nvim') && &term !~ 'xterm'
    " the two options will only be set when &term is `xterm` like
    let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
    let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
endif

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
    autocmd BufWritePost ~/.config/nvim/**.vim,~/.vimrc ++nested 
                \source <afile> 
                \| echom "Reloaded " . expand('<afile>') 
                \| edit
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

""" enable jump to last position 
augroup JumpLastPosition
    autocmd!
    autocmd BufReadPost *
                \ if line("'\"") >= 1 && line("'\"") <= line("$")
                \ |   exe "normal! g`\""
                \ | endif
augroup END

""" basic config
filetype plugin indent on
syntax on
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
set splitbelow
set splitright
set exrc             " enable project-based vim config file
set list
set listchars=tab:›\ ,trail:-,space:⋅
set colorcolumn=120
set scrolloff=3
set showtabline=2
set pumheight=10
set pumwidth=10
if has('nvim')
    set pumblend=15
    set jumpoptions=stack
endif

""" Fold settings
let g:vimsyn_folding = 'af'
set foldlevel=5
set foldmethod=syntax
set fillchars+=fold:\ 
set foldtext=MyFoldText()
function! MyFoldText()
    let line = getline(v:foldstart)
    if (line[0] == ' ')
        let line = '▸' . line[1:]
    endif
    return line . ' ...'
endfunction

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
    Plug 'morhetz/gruvbox'
    Plug 'dracula/vim'
    Plug 'junegunn/seoul256.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'cocopon/iceberg.vim'
    Plug 'altercation/solarized'
    " if has('nvim-0.5')
    "     Plug 'navarasu/onedark.nvim'
    " else
    "     Plug 'joshdick/onedark.vim'
    " endif
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ayu-theme/ayu-vim'
    Plug 'sonph/onehalf', { 'rtp' : 'vim' }
    Plug 'sainnhe/sonokai'

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
    " Plug 'Yggdroot/indentLine'
    Plug 'machakann/vim-highlightedyank' " highlight yanked text
    Plug 'junegunn/goyo.vim'             " concentrate only on text!
    Plug 'junegunn/limelight.vim'        " highlight current paragraph
    Plug 'junegunn/vim-emoji'            " get emoji from name
    Plug 'ryanoasis/vim-devicons'        " awesome file icons
    Plug 'vim-airline/vim-airline'       " just status line
    " Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-startify'            " vim startup page
    Plug 'preservim/tagbar'              " show code structure by using ctags
    if has('nvim-0.5')
        " Plug 'lukas-reineke/indent-blankline.nvim'
        " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    endif

    " syntax highlighting
    " Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'cespare/vim-toml'
    Plug 'junegunn/rainbow_parentheses.vim'
    " Not need anymore because coc-clangd and coc has builtin semantic highlight support
    " Plug 'jackguo380/vim-lsp-cxx-highlight'

    " Plug 'sheerun/vim-polyglot'
    " Plug 'vim-syntastic/syntastic'
    Plug 'plasticboy/vim-markdown'

    " Plug 'preservim/nerdtree'
    " Plug 'Xuyuanp/nerdtree-git-plugin'

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
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }

    " Plug 'wikitopian/hardmode'

    call plug#end()

    " load configs for specified plugins
    if !get(g:, 'vimrc_loaded', v:false)
        source $VIM_PLUGIN_CONFIG_DIR/coc.vim
        source $VIM_PLUGIN_CONFIG_DIR/misc.vim
        source $VIM_PLUGIN_CONFIG_DIR/nerdtree.vim
        source $VIM_PLUGIN_CONFIG_DIR/fugitive.vim
        source $VIM_PLUGIN_CONFIG_DIR/gitgutter.vim
        source $VIM_PLUGIN_CONFIG_DIR/fzf.vim
        source $VIM_PLUGIN_CONFIG_DIR/lightline.vim
        " source $VIM_PLUGIN_CONFIG_DIR/treesitter.vim
    endif
endif

""" Load after plugin settings
source $VIM_CONFIG_DIR/color.vim
