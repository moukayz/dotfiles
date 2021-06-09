" basic map
nnoremap <leader>q  :q!<CR>
nnoremap <leader><leader>q  :qall!<CR>
nnoremap <leader>w  :w<CR>
nnoremap <leader><leader>w  :wall<CR>

nnoremap <Esc><Esc> :set hls!<CR>
nnoremap <leader>pi :PlugInstall<CR>

" use Y to duplicate line or selection
nnoremap Y yyp
vnoremap Y y`>pgv

" map modification for init.vim
nnoremap <leader>. <Esc>:tabe   $MYVIMRC<CR>
nnoremap <leader>r <Esc>:source $MYVIMRC<CR>

" keep search matches in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" resize window 
nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 3/4)<CR>

" set paste mode to copy text from other applications
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" use Alt-u to convert current word to uppercase in insert mode
inoremap <M-u> <ESC>viwUA

" use C-d to delete current line in insert mode
inoremap <C-d> <ESC>ddi

" use H and L to go the frist and the last char of current line
nnoremap H ^
nnoremap L $

" disable arrow keys in all mode
map <Up>    <nop>
map <Left>  <nop>
map <Right> <nop>
map <Down>  <nop>

nnoremap <C-p> <Esc>:FZF<CR>


" basic abbr
iabbr adn and
