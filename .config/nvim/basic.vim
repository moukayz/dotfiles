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
    silent autocmd BufWritePost ~/.config/nvim/**.vim,~/.vimrc ++nested 
                \source <afile> 
                \| echom "Reloaded " . expand('<afile>') 
                \| edit
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
    set laststatus=3
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

source $VIM_CONFIG_DIR/plugins.vim
source $VIM_CONFIG_DIR/color.vim
