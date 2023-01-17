let g:fzf_colors = {
            \'bg+' : ['bg', 'CursorLine']
            \}
let g:fzf_layout = { 'window' : { 'width' : 0.7, 'height' : 0.8 } }
let g:fzf_tags_command = 'ctags -R --fields=Kts'
let g:fzf_ignore_dirs = get(g:, 'fzf_ignore_dirs', ['.git', '.cache/clangd/index', 'build'])

" Overwrite FZF_DEFAULT_OPTS environment variable in vim
let $FZF_DEFAULT_OPTS="--preview-window 'up:60%'
            \ --bind ctrl-b:preview-page-up,ctrl-f:preview-page-down,
            \ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down" 

" Define dynamicall refreshed Rg-fzf
function! RipgrepFzf(query, fullscreen, filepath='', interactive=1)
    let command_fmt = 'rg --with-filename --column 
                \--line-number --no-heading --color=always --smart-case -- %s %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query), a:filepath)

    if a:interactive
        let reload_command = printf(command_fmt, '{q}', a:filepath)
        let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    else
        let spec = {'options': ['--query', a:query]}

    endif
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" search text with rg in projects
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
nnoremap <silent> <M-f> :<C-u>RG<CR>

" search text in current buffer(default non-interactive)
command! -nargs=* -bang RGBuffer call RipgrepFzf(<q-args>, <bang>0, expand('%'), 0)
nnoremap <silent> <leader>sb :<C-u>RGBuffer<CR>

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

function! s:FzfWithMRU(path)
    let l:mru_fzf_command = 'fd --no-ignore --type f --hidden --follow -E ' . join(g:fzf_ignore_dirs, " -E ")
    " let l:mru_fzf_command = 'fd --type f --hidden --follow --exclude .git -X ls -t'
    let l:saved_command = $FZF_DEFAULT_COMMAND

    " if in git repo, change fzf command to sort file with mtime(mru)
    " if not in git repo, just use the default fzf command 
    if utils#IsInGitRepo()
        let $FZF_DEFAULT_COMMAND = l:mru_fzf_command
    endif

    if empty(a:path)
        FZF
    else
        FZF a:path
    endif

    let $FZF_DEFAULT_COMMAND = l:saved_command
endfunction

" quick open files in the project
nnoremap <C-p> <Esc>:call <SID>FzfWithMRU('')<CR>

command! -bang -nargs=* FzfSymbols call fzf#vim#tags(
            \<q-args>, 
            \fzf#vim#with_preview({"options":[ "--with-nth","1,2,4..-2", "--nth", "1", "--preview-window", "+{3}-/2", "--prompt", "Symbols> " ], "placeholder": " --tag {2}:{-1}:{3..}"}), 
            \<bang>0)
command! -bang -nargs=* FzfOutline call fzf#vim#buffer_tags(
            \<q-args>, 
            \printf('ctags -f - --sort=yes --fields=Kts --excmd=number %s', fzf#shellescape(expand('%'))),
            \fzf#vim#with_preview({ "options": [ "--prompt", "Outline> " ], "placeholder": "{2}:{3..}" }), 
            \<bang>0)


" Maps for symbols and outline using fzf
nnoremap <leader>tt <Esc>:<C-u>FzfSymbols<CR>
nnoremap <leader>tc <Esc>:<C-u>FzfOutline<CR>

let s:default_expect_keys = 'ctrl-v,ctrl-t,ctrl-s'
" Maps for location list using fzf
function! FzfCocLocation(...)
    let locs = deepcopy(g:coc_jump_locations)

    let preview_window_opts = ["--preview-window", "+{2}-/2" ]
    let extra_opts = [ '--multi', '--ansi', 
                \'--expect', s:default_expect_keys,
                \'--delimiter', '\t', 
                \'--with-nth', '1,2,4..' ]
    let fzf_opts = {
                \'source' : s:format_location(locs),
                \'sink*' : function('s:location_sink'),
                \'options' : extra_opts + preview_window_opts,
                \"placeholder" : "{1}:{2..}"
                \}

    call fzf#run(fzf#wrap(fzf#vim#with_preview(fzf_opts)))

endfunction

" define color wrapper functions ( eg. `with_red(str)` )
let s:ansi_map = {'black': 30, 'red': 31, 'green': 32, 'yellow': 33, 'blue': 34, 'magenta': 35, 'cyan': 36}
for s:color in keys(s:ansi_map)
    execute "function! s:with_" . s:color . "(str)\n"
                \" let l:code = s:ansi_map['" . s:color . "']\n"
                \" return printf(\"\\x1b[%s;1m%s\\x1b[m\",l:code, a:str)\n"
                \" endfunction"
endfor

function! s:format_location(locations) abort
    if empty(a:locations)
        return
    endif

    call map(a:locations, 's:location_to_list(v:val)')
    let l:aligned_lists = s:align_lists(a:locations)

    call map(l:aligned_lists, 'join(v:val, "\t")')

    return l:aligned_lists
endfunction

function! s:location_to_list(loc)
    if type(a:loc) != type({})
        return []
    endif

    let filename =  s:with_cyan(fnamemodify(a:loc.filename, ":p:."))
	return  [filename, a:loc.lnum, a:loc.col, trim(a:loc.text)]
endfunction


function! s:location_sink(lines)
    if len(a:lines) < 2
        return 
    endif

    let cmd = s:action_for(a:lines[0], 'e')
    let list = map(filter(a:lines[1:], 'len(v:val)'), 's:location_parser(v:val)')
    if empty(list)
        return
    endif

    let first = list[0]
    try
        call s:open(cmd, first.filename)
        execute first.lnum
        call cursor(0, first.col)
        normal! zvzz
    catch
    endtry

endfunction

function! s:location_parser(loc)
    if empty(a:loc)
        return
    endif

    let l:items = split(a:loc, '\t')
    return {'filename': l:items[0], 'lnum': l:items[1], 'column': l:items[2], 'text': l:items[3]}
endfunction

let s:default_action = {
  \ 'ctrl-t': 'tabnew',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:action_for(key, ...)
  let default = a:0 ? a:1 : ''
  let Cmd = get(get(g:, 'fzf_action', s:default_action), a:key, default)
  return type(Cmd) == type('') ? Cmd : default
endfunction

function! s:open(cmd, target)
  " If open current buffer with 'edit' command, then do nothing
  if stridx('edit', a:cmd) == 0 && fnamemodify(a:target, ':p') ==# expand('%:p')
    return
  endif
  execute a:cmd a:target
endfunction

function! s:align_lists(lists)
  let maxes = {}
  for list in a:lists
    let i = 0
    while i < len(list)
      let maxes[i] = max([get(maxes, i, 0), len(list[i])])
      let i += 1
    endwhile
  endfor
  for list in a:lists
    call map(list, "printf('%-'.maxes[v:key].'s', v:val)")
  endfor
  return a:lists
endfunction

""" Override Coc's location list with fzf
" augroup CocFzfLocation
"   autocmd!
"   let g:coc_enable_locationlist = 0
"   autocmd User CocLocationsChange nested call FzfCocLocation()
" augroup END
