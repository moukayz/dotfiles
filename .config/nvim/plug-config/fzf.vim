" Define dynamicall refreshed Rg-fzf
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" search text with rg in projects
nnoremap <silent> <M-f> :<C-u>RG<CR>

" In order to search literal `\` , have to double escape it
" eg. `:RG '\\\\' ` -> `eval("rg '\\\\'")` -> `rg '\\' (in shell)` -> rg will
" search literal `\`
" No need to use `shellescape` because `RG` command will do this for us
function! s:EscapeRgRegexChars(input)
    return escape(escape(a:input, '\()[]{}*^$.+?'), '\')
endfunction

" search WORD under cursor
nnoremap <silent> <leader>sw :<C-u>execute "RG " . <SID>EscapeRgRegexChars(expand('<cWORD>'))<CR>
" search text motion with RG
nnoremap <leader>s :set operatorfunc=<SID>RgOperator<cr>g@
vnoremap <leader>s :<c-u>call <SID>RgOperator(visualmode())<cr>

function! s:RgOperator(type)
    let saved_reg = @@

    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif

    execute "RG " . <SID>EscapeRgRegexChars(@@)
    let @@ = saved_reg
endfunction

" search and execute commands quickly
nnoremap <silent> <M-p> :<C-u>Commands<CR>
" quick open files in the project
nnoremap <C-p> <Esc>:FZF<CR>

