""""""""""""""""""""""""" colorful

let g:onedark_style = 'warm'

let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:sonokai_better_performance = 1
let g:sonokai_style = 'shusia'

" Gruvbox theme configs
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column = 'bg0'
" let g:gruvbox_improved_strings = 1
let g:gruvbox_improved_warnings = 1

let g:onedark_terminal_italics = 1
color onedark
" color gruvbox

" color sonokai
set noshowmode

""" Custom highlight settings
hi! CursorLineNr ctermfg=Yellow guifg=magenta
hi! Folded cterm=reverse gui=reverse

""" Set current diagnostic highlight colors
function! s:get_highlight_attr(group, attr)
    return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

function! s:set_diagnostic_highlight(group, fg)
    exec 'hi! ' . a:group .' gui=undercurl guisp=' . a:fg
endfunction
let s:error = s:get_highlight_attr('CocErrorSign', 'fg#')
let s:warning = s:get_highlight_attr('CocWarningSign', 'fg#')
let s:info = s:get_highlight_attr('CocInfoSign', 'fg#')
let s:hint = s:get_highlight_attr('CocHintSign', 'fg#')
call s:set_diagnostic_highlight('CocErrorHighlight', s:error)
call s:set_diagnostic_highlight('CocWarningHighlight', s:warning)
call s:set_diagnostic_highlight('CocInfoHighlight', s:info)
call s:set_diagnostic_highlight('CocHintHighlight', s:hint)

exec 'hi! CocHighlightText guibg=' . s:get_highlight_attr('Comment', 'fg#')

""" Customized coc syntax highlighting
if get(g:, 'colors_name') == "onedark"
    call onedark#extend_highlight('Function', {'gui':'Bold,Italic'})
    call onedark#extend_highlight('Constant', {'gui':'Italic'})
endif

hi! link CocSemClass Structure
hi! link GitLensText Comment
