""""""""""""""""""""""""""""" Plugin config
""" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g_syntastic_auto_loc_list            = 1
let g_syntastic_check_on_open            = 1
let g_syntastic_check_on_wq              = 0

""" RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let rainbow_blacklist = ['vimwiki', 'md']
augroup RainbowPrarent
    autocmd!
    autocmd BufEnter,WinEnter * RainbowParentheses!
    autocmd BufEnter,WinEnter * if index(rainbow_blacklist, &ft) < 0 | RainbowParentheses
augroup end

""" CppEnhancedHighlight
let g:cpp_class_scope_hightlist           = 1
let g:cpp_member_variable_highlight       = 1
let g:cpp_class_decl_highlight            = 1
let g:cpp_posix_standard                  = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

""" CppClangComplete
let g:clang_library_path = '/usr/lib/llvm-10/lib'

""" vim-airline
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

""" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

""" NerdCommenter
let g:NERDSpaceDelims            = 1
let g:NERDCompactSexyComs        = 1
let g:NERDDefaultAlign           = 'left'
let g:NERDCommentEmptyLines      = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines    = 1

""" devicons
let g:webdevicons_conceal_nerdtree_brackets = 0

""" vim-hardmode
let g:HardMode_level='wannabe'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

