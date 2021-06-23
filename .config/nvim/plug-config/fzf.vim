" Define dynamicall refreshed Rg-fzf
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" search text in projects
nnoremap <silent> <M-f> :<C-u>RG<CR>

" search and execute commands quickly
nnoremap <silent> <M-p> :<C-u>Commands<CR>

nnoremap <C-p> <Esc>:FZF<CR>
