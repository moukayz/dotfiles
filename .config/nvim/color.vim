""""""""""""""""""""""""" colorful

let g:onedark_style = 'warm'

let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_virtual_text = 'colored'
let g:sonokai_better_performance = 1
let g:sonokai_style = 'shusia'

" Gruvbox theme configs
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_sign_column = 'bg0'
" let g:gruvbox_improved_strings = 1
let g:gruvbox_improved_warnings = 1

color gruvbox

set noshowmode

""" Custom highlight settings
hi! link CocHighlightText IncSearch
hi! CursorLineNr ctermfg=Yellow guifg=magenta
" hi! cursorline ctermbg=DarkGray guibg=#404040
hi! Folded cterm=reverse gui=reverse
" hi! TabLineSel guibg=#ff00ff guifg=black ctermbg=magenta
