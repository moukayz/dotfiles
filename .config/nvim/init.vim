""" set fzf vim auto completion
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

""" set nvim python provider
let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python_provider = 0

""" set true color
set termguicolors
set background=dark

""" Plugins
call plug#begin()
" colorschemes
Plug 'dracula/vim'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'

Plug 'vim-airline/vim-airline'
" Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" tools
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" display
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-emoji'
Plug 'ryanoasis/vim-devicons'

" syntax highlighting
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'sheerun/vim-polyglot'


Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" git
Plug 'tpope/vim-fugitive'

" cpp
Plug 'xavierd/clang_complete'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
call plug#end()

""" basic config
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd showmode
set fillchars+=vert:\
set wrap breakindent
set encoding=utf-8
set title
set number


""" keymap
let mapleader="\\"
" basic map
nmap <leader>q :q!<CR>
nmap <leader>w :wall<CR>
nmap <leader>r :source ~/.config/nvim/init.vim<CR>
" Nerdtree map
nmap <leader>e :NERDTreeToggle<CR>




""" Plugin config
" NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeNodeDelimiter="\x07"

" RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" CppEnhancedHighlight
let g:cpp_class_scope_hightlist = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

" CppClangComplete
let g:clang_library_path = '/usr/lib/llvm-10/lib'

" Lightline
let g:lightlie = {
    \ 'colorscheme' : 'seoul256',
    \ }

" vim-airline
let g:airline_theme='onedark'

""" auto cmd for plugins
" enable rainbow_parenthesis on startup
autocmd VimEnter * RainbowParentheses

""" colorful
syntax on
set noshowmode
color onedark
