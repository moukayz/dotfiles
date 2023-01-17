if !exists(":CocEnable")
    echo "coc.vim disabled, not souring coc configs!!\n\n"
    finish
endif

""" Coc
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c

let g:coc_default_semantic_highlight_groups = 1

" set coc extensions
let g:coc_global_extensions = [
            \'coc-clangd',
            \'coc-cmake',
            \'coc-css',
            \'coc-explorer',
            \'coc-json',
            \'coc-marketplace',
            \'coc-pyright',
            \'coc-sh',
            \'coc-spell-checker',
            \'coc-fzf-preview',
            \'coc-diagnostic',
            \'coc-vimlsp',
            \'coc-highlight',
            \'coc-lua',
            \'coc-html',
            \'coc-snippets'
            \]

" auto restart coc.nvim when coc-settings.json is changed
augroup ReloadCoc
    autocmd!
    autocmd BufWritePost $COC_VIMCONFIG/coc-settings.json CocRestart
augroup END


if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif

" Make <tab> used for completion confirm, snippet expand and jump like VSCode.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? 
                \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : 
                \ "\<TAB>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-tab>'

" Use <C-n>, <C-p>, <up> and <down> to navigate completion list: >
inoremap <silent><expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : coc#refresh()
inoremap <silent><expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"

" Use <c-n> to trigger completion.
" inoremap <silent><expr> <c-n> coc#refresh()


" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)

" text obj map
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)

xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :<C-u>call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K  :call <SID>show_documentation()<CR>
nnoremap <silent> gh :call CocActionAsync('doHover')<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction

function! s:show_highlight()
    if &ft != 'log'
        call CocActionAsync('highlight')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
augroup HoldHighlight
    autocmd!
    autocmd CursorHold * silent call s:show_highlight()
augroup END

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Formatting 
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
nmap <space>f  <Plug>(coc-format)
command! -nargs=0 FormatBuffer :silent! call CocActionAsync('format')

" Format code buffer on save
" augroup FormatSave
"     autocmd!
"     autocmd BufWritePost * FormatBuffer
" augroup END

" map coc action
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
nmap <space>a  <Plug>(coc-codeaction-cursor)

""" map for coc-explorer
nnoremap <space>ee :CocCommand explorer<CR>
" Use preset argument to open it
" `<s>ed` to open nvim config dir tree
nnoremap <space>ed :CocCommand explorer --preset .vim<CR> 
" `<s>ef` to open floating dir tree
nnoremap <space>ef :CocCommand explorer --preset floating<CR>
" `<s>ec to open dir tree of the current buffer`
nnoremap <space>ec :CocCommand explorer --root-strategies sourceBuffer<CR>
" `<s>eb to open current buffers tree`
nnoremap <space>eb :CocCommand explorer --preset buffer<CR>
" open explorer when vim opens a directory
autocmd StdinReadPre * let s:std_in=1

augroup OpenExplorerWhenStart
    autocmd!
    " disable vim default actions when opening a directory
    autocmd VimEnter * silent! autocmd! FileExplorer
    autocmd VimEnter * 
                \if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
                \| exe 'CocCommand explorer '.argv()[0] | wincmd p | enew | wincmd p
                \| exe 'cd '.argv()[0]
                \| endif
augroup END

" auto close explorer when it's the last window in vim
augroup QuitExplorerWhenLast
    autocmd!
    autocmd BufEnter \[coc-explorer\]-*
                \ if winnr('$') == 1
                \ | q | endif
augroup END

" List all presets
nnoremap <space>el :CocList explPresets"

" show function signature in insert mode
inoremap <expr> <M-h> CocActionAsync('showSignatureHelp')
nnoremap <space>h :<C-u>call CocActionAsync('showSignatureHelp')<CR>
nnoremap <space>? :<C-u>call CocActionAsync('diagnosticInfo')<CR>

" Maps for CocList
nnoremap <space>tt :<C-u>CocList --interactive --auto-preview symbols<CR>
nnoremap <space>tc :<C-u>CocList outline<CR>
nnoremap <space>p  :<C-u>CocList commands<CR>
nnoremap <space>x  :<C-u>CocList extensions<CR>
nnoremap <space>s  :<C-u>CocList grep<CR>
nnoremap <space>r  :<C-u>CocList mru<CR>
nnoremap <space>f  :<C-u>CocList files<CR>

" Switch source and header use clangd
nnoremap <space>o :<C-u>CocCommand clangd.switchSourceHeader<CR>
nnoremap <space>O :<C-u>CocCommand clangd.switchSourceHeader vsplit<CR>
