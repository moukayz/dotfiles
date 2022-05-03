let g:lightline = {
            \'subseparator': {'left': "|", 'right': '⁌'},
            \'colorscheme' : 'sonokai',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'cocstatus', 'readonly', 'filename', 'modified', 'cocfunction'] ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'LightCocStatus',
            \   'cocfunction': 'LightCocFunction',
            \   'cwd': 'LightCwd'
            \ },
            \'tabline': {
                \'left': [ [ 'tabs' ] ],
                \'right': [ ['cwd', 'close'] ]
                \}
            \ }

function! LightCwd() abort
    return fnamemodify(getcwd(), ':~')
endfunction

function! LightCocStatus() abort
    if exists(':CocAction')
        return coc#status()
    endif

    return ""
endfunction

function! LightCocFunction() abort
    return get(b:, 'coc_current_function', '')
endfunction

let g:coc_status_error_sign = "E:"
let g:coc_status_warning_sign = "W:"

augroup LightlineUpdate
    autocmd!
    autocmd User CocStatusChange,CocDiagnosticChange * silent! call lightline#update() 
augroup END

