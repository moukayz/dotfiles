""" set fzf vim auto completion
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

""" set nvim python provider
let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python_provider = 0

""" set true color
set termguicolors
set background=dark

""" Automatically install vim-plug according to the editor used
" if empty(glob('"${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim'))
"     silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
"                 \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" endif

""" Plugins
call plug#begin()
" colorschemes
Plug 'dracula/vim'
Plug 'junegunn/seoul256.vim'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline-themes'

" snippets
" Plug 'SirVer/ultisnips'
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
Plug 'vim-syntastic/syntastic'
Plug 'plasticboy/vim-markdown'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" git
Plug 'tpope/vim-fugitive'

" cpp
Plug 'xavierd/clang_complete'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" misc
Plug 'easymotion/vim-easymotion'
Plug 'vimwiki/vimwiki'

" code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vim ninjia !!!!
Plug 'wikitopian/hardmode'

call plug#end()

""" Automatically install missing plugins on startup
" if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif



""" keymap
let mapleader="\\"
" basic map
nmap <leader>q  :q!<CR>
nmap <leader>w  :wall<CR>
nmap <Esc><Esc> :set hls!<CR>
nmap <leader>pi :PlugInstall<CR>

" use Y to duplicate line or selection
nmap Y yyp
vmap Y y`>pgv

" map modification for init.vim
nnoremap <leader>. <Esc>:tabe   $MYVIMRC<CR>
nnoremap <leader>r <Esc>:source $MYVIMRC<CR>
augroup ReloadVim
    autocmd!
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw | e
augroup END

" keep search matches in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" resize window 
nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 3/4)<CR>

" Nerdtree 
nmap <leader>e :NERDTreeToggle<CR>
" Tagbar
nmap <leader>ss :TagbarToggle<CR>

""""""""""""""""""""""""""""" Plugin config
""" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g_syntastic_auto_loc_list            = 1
let g_syntastic_check_on_open            = 1
let g_syntastic_check_on_wq              = 0

""" airline
let g:airline#extensions#tabline#enabled = 1

""" vimwiki
hi VimwikiHeader1 guifg=cyan
hi VimwikiHeader2 guifg=green
hi VimwikiHeader3 guifg=yellow
hi VimwikiHeader4 guifg=blue
hi VimwikiHeader5 guifg=blue
hi VimwikiHeader6 guifg=blue
hi VimwikiLink term=underline ctermfg=cyan guifg=cyan gui=underline
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

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

call NERDTreeHighlightFile('cpp',    'cyan',   'none', 'green',   '#151515')
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

""" RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let rainbow_blacklist = ['vimwiki', 'md']
augroup RainbowPrarent
    autocmd!
    autocmd BufEnter,WinEnter * RainbowParentheses!
    autocmd BufEnter,WinEnter * if index(rainbow_blacklist, &ft) < 0 | RainbowParentheses
augroup end

""" CppEnhancedHighlight
let g:cpp_class_scope_hightlist           = 1
let g:cpp_member_variable_highlight       = 1
let g:cpp_class_decl_highlight            = 1
let g:cpp_posix_standard                  = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

""" CppClangComplete
let g:clang_library_path = '/usr/lib/llvm-10/lib'

""" Lightline
let g:lightlie = {
    \ 'colorscheme' : 'seoul256',
    \ }

""" vim-airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

""" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""" NerdCommenter
let g:NERDSpaceDelims            = 1
let g:NERDCompactSexyComs        = 1
let g:NERDDefaultAlign           = 'left'
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines    = 1

"""ultisnips
let g:UltiSnipsExpandTrigger=""

""" devicons
let g:webdevicons_conceal_nerdtree_brackets = 0

""" Coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Make <tab> used for trigger completion, completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
         \ pumvisible() ? coc#_select_confirm() :
         \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
         \ <SID>check_back_space() ? "\<TAB>" :
         \ coc#refresh()

function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

""" vim-hardmode
let g:HardMode_level='wannabe'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

""" enable syntax for local bash config file
autocmd BufRead,BufNewFile,BufEnter .bash.* set filetype=sh

""" basic config
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set ruler laststatus=2 showcmd
"set fillchars+=vert:\
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
color onedark
" color dracula
