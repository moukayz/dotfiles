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
Plug 'vim-airline/vim-airline-themes'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" tools
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align' " alianment operations
Plug 'tpope/vim-surround'      " surrounding operations
Plug 'preservim/nerdcommenter' " auto comment with shortcut

" display
Plug 'junegunn/goyo.vim'       " concentrate only on text!
Plug 'junegunn/limelight.vim'  " highlight current paragraph
Plug 'junegunn/vim-emoji'      " get emoji from name
Plug 'ryanoasis/vim-devicons'  " awesome file icons
Plug 'vim-airline/vim-airline' " just status line
" Plug 'itchyny/lightline.vim' " another status line
Plug 'mhinz/vim-startify'      " vim startup page
Plug 'preservim/tagbar'        " show code structure by using ctags

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
"set fillchars+=vert:\
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
" Nerdtree 
nmap <leader>e :NERDTreeToggle<CR>
" Tagbar
nmap <leader>ss :TagbarToggle<CR>

""" Plugin config
""" NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeNodeDelimiter="\x07"
let g:NERDTreeShowHidden=1
" exit vim when nerdtree is the only window
autocmd bufenter * if winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | q | endif
" open nerdtree when vim opens a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" highlight filename based on its extension
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
   exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='.  a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
   exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'.  a:extension .'$#'
endfunction

call NERDTreeHighlightFile('cpp',    'green',   'none', 'green',   '#151515')
call NERDTreeHighlightFile('ini',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('c',      'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('h',      'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('cxx',    'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')

" RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
autocmd VimEnter * RainbowParentheses

" CppEnhancedHighlight
let g:cpp_class_scope_hightlist           = 1
let g:cpp_member_variable_highlight       = 1
let g:cpp_class_decl_highlight            = 1
let g:cpp_posix_standard                  = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

" CppClangComplete
let g:clang_library_path = '/usr/lib/llvm-10/lib'

" Lightline
let g:lightlie = {
    \ 'colorscheme' : 'seoul256',
    \ }

" vim-airline
let g:airline_theme='onedark'

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" NerdCommenter
let g:NERDSpaceDelims            = 1
let g:NERDCompactSexyComs        = 1
let g:NERDDefaultAlign           = 'left'
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines    = 1

""" colorful
syntax on
set noshowmode
color onedark
