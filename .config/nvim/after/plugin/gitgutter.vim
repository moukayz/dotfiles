" change default gutter signs
let g:gitgutter_sign_added = '*'
let g:gitgutter_sign_modified = '@'
let g:gitgutter_sign_removed_above_and_below = '±︁'
let g:gitgutter_sign_removed = '>'
let g:gitgutter_sign_modified_removed = '-'

" cycle through hunks in current buffer
function! GitGutterPrevHunkCycle()
    let line = line('.')
    silent! GitGutterPrevHunk
    if line('.') == line
        call cursor(line('$'), 0)
        GitGutterNextHunk
        if line('.') == line("$")
            call cursor(line, 0)
        endif
    endif
endfunction

function! GitGutterNextHunkCycle()
    let line = line('.')
    silent! GitGutterNextHunk
    if line('.') == line
        1
        GitGutterNextHunk
        if line('.') == 1
            call cursor(line, 0)
        endif
    endif
endfunction

" nmap ]c :<C-u>call GitGutterNextHunkCycle()<CR>
" nmap [c :<C-u>call GitGutterPrevHunkCycle()<CR>
"
