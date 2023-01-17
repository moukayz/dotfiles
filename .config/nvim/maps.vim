" basic map
nnoremap <leader>q  :q!<CR>
nnoremap <leader><leader>q  :qall!<CR>
nnoremap <leader>w  :w<CR>
nnoremap <leader><leader>w  :wall<CR>

nnoremap <Esc><Esc> :nohlsearch<CR>
nnoremap <leader>pi :PlugInstall<CR>

" use Y to duplicate line or selection
nnoremap Y yyp
vnoremap Y y`>pgv

" map modification for init.vim
nnoremap <silent> <leader>. <Esc>:tabe   $MYVIMRC<CR>
nnoremap <silent> <leader>r <Esc>:source $MYVIMRC \| redraw \| e<CR>

" keep search matches in the middle of the screen
nnoremap n nzz
nnoremap N Nzz
nnoremap # #zz
nnoremap * *zz

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

" use H and L to go the first and the last char of current line
nnoremap H ^
nnoremap L $

" Maps for tabpage navigation
nnoremap <M-h> :tabprevious<CR>
nnoremap <M-l> :tabnext<CR>

" disable arrow keys in all mode
map <Up>    <nop>
map <Left>  <nop>
map <Right> <nop>
map <Down>  <nop>

let s:header_ext = ['h', 'hpp']
let s:src_ext = ['cc', 'cpp', 'cxx']
function! SwitchHeadSrc(file)
    let ext = fnamemodify(a:file, ':e')
	let base = fnamemodify(a:file, ':t:r')
    if index(s:header_ext, ext) >= 0
        let switch_ext = s:src_ext
    elseif index(s:src_ext, ext) >= 0
        let switch_ext = s:header_ext
    else
        return
    endif

    for curr in switch_ext
        let switch_file = base . '.' . curr
        " let switch_filepath = findfile(switch_file, getcwd() . '/**/')
        let find_cmd = executable('fd') ? 'fd --type f ' . switch_file : 'find ' . getcwd() . ' -type f -name ' . switch_file 
        let switch_filepath = system(find_cmd)
        if len(switch_filepath)
            execute 'edit' switch_filepath
            return
        else
            echo "Not found " . switch_file
        endif
    endfor
endfunction

" Map to switch between c/c++ source and header files
inoremap <M-o> <C-o>:<C-u>call SwitchHeadSrc(expand('%'))<CR><Esc>
nnoremap <M-o> <Esc>:<C-u>call SwitchHeadSrc(expand('%'))<CR><Esc>

" basic abbr
iabbr adn and

" commandline mode maps
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <M-f> <S-Right>
