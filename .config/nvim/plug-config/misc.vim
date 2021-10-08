""""""""""""""""""""""""""""" Plugin config
""" Tagbar
nnoremap <leader>ss :<C-u>Tagbar<CR>

""" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g_syntastic_auto_loc_list            = 1
" let g_syntastic_check_on_open            = 1
" let g_syntastic_check_on_wq              = 0
"

""" RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = [233,234,235,238,248,59]
" this plugin will conflict with some filetypes, so disable it for those types
let s:rainbow_blacklist = ['vimwiki', 'md', 'cmake', 'help']
" augroup SetRainbowParentheses
"     autocmd!
"     autocmd BufEnter,WinEnter *
"                 \  if index(s:rainbow_blacklist, &ft) >= 0
"                 \|     silent! RainbowParentheses!
"                 \| else
"                 \|     silent! RainbowParentheses
"                 \| endif
" augroup end
"
""" CppEnhancedHighlight
let g:cpp_class_scope_hightlist           = 1
let g:cpp_member_variable_highlight       = 1
let g:cpp_class_decl_highlight            = 1
let g:cpp_posix_standard                  = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

""" vim-airline
let g:airline_theme='base16_gruvbox_dark_hard'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#format = 2
let g:airline#extensions#lsp#show_line_numbers = 0
let g:airline#extensions#coc#error_symbol = '︁'
let g:airline#extensions#coc#error_symbol = '︁'
let g:airline#extensions#lsp#warning_symbol = '⚠︁'
let g:airline#extensions#lsp#warning_symbol = '⚠︁'
let g:airline#extensions#whitespace#show_message = 0
let g:airline#extensions#whitespace#checks = []

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

""" vim-hardmode
let g:HardMode_level='wannabe'
augroup VimHardMode
    autocmd!
    autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
augroup END

""" vim-highlightedyank
let g:highlightedyank_highlight_duration = 500
let b:highlightedyank_highlight_duration = 500

""" vim-rooter
" for non-project files, change working directory to the dir of the current buffer
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_patterns = ['.git', '.svn', 'package.json', '.vscode', 'init.vim']

""" AutoPair
" disable auto-pair map
let g:AutoPairsShortcutToggle = ''

""" IndentLine
" let g:indentLine_enabled = 0
" if &encoding == 'utf-8'
"     let g:indentLine_char = '│'
" endif

""" IndentBlankLine
let g:indent_blankline_show_first_indent_level = v:false
let g:indent_blankline_buftype_exclude = ['terminal', 'help']
let g:indent_blankline_show_current_context = v:false
