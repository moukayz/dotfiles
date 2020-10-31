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

" keep search matches in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

" resize window 
nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 3/4)<CR>

" auto close parenthiese
inoremap " ""<left>
inoremap ' ''<left>
" inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
