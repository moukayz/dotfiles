if has('nvim')

let g:terminals = get(g:, 'terminals', {})
let g:last_terminal_nr = get(g:, 'last_terminal_nr', -1)

function! NewTerminal(shell = "")
    let l:shell = $SHELL
    if !empty(a:shell) && executable(a:shell)
        let l:shell = a:shell
    elseif executable('fish')
        let l:shell = 'fish'
    elseif executable('zsh')
        let l:shell = 'zsh'
    endif

    let l:term_win_nr = s:get_terminal_win()
    if l:term_win_nr >= 0
        " if there is already a terminal window, reuse it for the new terminal
        execute l:term_win_nr . 'wincmd w'
        execute 'edit term://' . l:shell
    else
        " else just create a new terminal window
        execute 'botright split term://' . l:shell
    endif

    let g:terminals[bufnr()] = bufname()
endfunction

function! ShowTerminal(term_nr = -1)
    if has_key(g:terminals, a:term_nr)
        let l:curr_term = a:term_nr
    elseif has_key(g:terminals, g:last_terminal_nr)
        let l:curr_term = g:last_terminal_nr
    elseif !empty(g:terminals)
        let l:curr_term = keys(g:terminals)[0]
    endif

    " Open and split the terminal
    execute 'botright split ' . g:terminals[l:curr_term]
endfunction

function! ToggleTerminal()
    " If there is a terminal window, close it
    let l:term_win_nr = s:get_terminal_win()
    if l:term_win_nr >= 0
        if winnr() == l:term_win_nr
            wincmd p
        endif
        execute l:term_win_nr . 'close'

        return
    endi

    " If there is no terminal window, show or create one
    if !empty(g:terminals)
        call ShowTerminal()
    else
        call NewTerminal()
    endif
endfunction

function! s:is_terminal_win(winnr = winnr()) abort
    return has_key(g:terminals, winbufnr(a:winnr))
endfunction

" check if the current terminal window is splited(eg. two terminal windows are
" vertically splited)
function! s:in_split_term()
    " true if current win is terminal and the left or right win is terminal
    let l:cwin = winnr()
    if s:is_terminal_win(l:cwin)
        let l:lwin = winnr('h')
        let l:rwin = winnr('l')
        return l:lwin != l:cwin && s:is_terminal_win(l:lwin) 
                    \|| l:rwin != l:cwin && s:is_terminal_win(l:rwin)
    endif
    return v:false
endfunction

" return winnr of the current terminal window if exists, otherwise -1
function! s:get_terminal_win() abort
    for nr in keys(g:terminals)
        let l:term_win_nr = bufwinnr(str2nr(nr))
        if l:term_win_nr >= 0
            return l:term_win_nr
        endif
    endfor

    return -1
endfunction

function! s:show_term_across_tabs() abort
    echom "new tab!!!"
    let l:last_tab_bufs = tabpagebuflist(tabpagenr('#'))
    if type(l:last_tab_bufs) != type([])
        return
    endif

    for l:bufnr in l:last_tab_bufs
        if has_key(g:terminals, l:bufnr) && s:get_terminal_win() == -1
            call ShowTerminal(l:bufnr)
            return
        endif
    endfor
endfunction

function! s:hide_current_terminal()
    let l:bufnr = bufnr()
    wincmd p
    execute bufwinnr(l:bufnr) . 'close'
endfunction

function! s:change_terminal(next = v:true)
    let l:bufnr = bufnr()
    let l:terms = keys(g:terminals)
    let l:curr_term_index = index(l:terms, string(l:bufnr))
    if l:curr_term_index >= 0
        let l:delta = a:next ? 1 : -1
        let l:next_term_nr = l:terms[(l:curr_term_index + l:delta) % len(l:terms)]
        execute 'buffer ' . l:next_term_nr
    endif
    normal! i
endfunction

function! s:setup_terminal_win()
    if &buftype == 'terminal'
        " start insert mode when entering terminal window
        " startinsert

        " only set layout when the terminal window is created(not entered)
        if !exists('w:term_created')
            let w:term_created = 1
            if !s:in_split_term()
                " wincmd J
                execute 'resize ' . float2nr(&lines * 0.3)
            endif
        endif
    endif
endfunction

function! ListTerminal()
    let l:loclist = []
    for l:buf in keys(g:terminals)
        let l:loc_item = {'bufnr': l:buf, 'lnum':1, 'col':1, 'valid':1, 'type':'', 'text':''}
        call add(l:loclist, l:loc_item)
    endfor
    call setloclist(winnr(), l:loclist)
    lwindow
endfunction

augroup SetupEmbeddedTerminal
    autocmd!
    autocmd TermOpen * startinsert 
                \| setlocal nonumber 
                \| setlocal norelativenumber
                \| setlocal noruler
                \| setlocal bufhidden=hide

    " adjust terminal window's size, position and mode
    autocmd BufEnter * call s:setup_terminal_win()

    " store the last accessed terminal buf
    autocmd TermLeave * let g:last_terminal_nr = bufnr()

    " remove buffer when terminal closed(eg. execute 'exit')
    autocmd TermClose * if has_key(g:terminals, bufnr()) 
                \| unlet g:terminals[bufnr()]
                \| endif
                \| call feedkeys("\<Ignore>")

    " autocmd TabEnter * call <SID>show_term_across_tabs()
augroup END

command! -nargs=? NewTerminal call NewTerminal(<q-args>)
command! -nargs=0 ListTerminal echo get(g:, 'terminals', {})

tnoremap <C-g> <C-\><C-N>
" To use `ALT+{h,j,k,l}` to navigate windows from terminal mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
" Switch to next or previous terminal
tnoremap <M-]> <C-\><C-N>:call <SID>change_terminal()<CR>
tnoremap <M-[> <C-\><C-N>:call <SID>change_terminal(v:false)<CR>
" hide terminal window
" tnoremap <M-t> <C-\><C-N>:call <SID>hide_current_terminal()<CR>
tnoremap <M-t> <C-\><C-N>:let nr = bufnr() \| wincmd p \| execute bufwinnr(nr) . 'close'<CR>
" toggle terminal window in normal and insert mode
inoremap <M-t> <Esc>:<C-u>call ToggleTerminal()<CR>
nnoremap <M-t> <Esc>:<C-u>call ToggleTerminal()<CR>

endif
