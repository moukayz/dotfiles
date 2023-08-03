" fugitive
nnoremap <silent> <leader>gs <Esc>:Git<CR>
nnoremap <silent> <leader>glo <Esc>:Git log --name-only<CR>
nnoremap <silent> <leader>gb <Esc>:Git blame<CR>
nnoremap <silent> <leader>gd <Esc>:Gvdiffsplit<CR>
nnoremap <silent> <leader>gm <Esc>:Gvdiffsplit!<CR>
nnoremap <silent> <leader>ge <Esc>:Gedit<CR>

" diffview
nnoremap <silent> <leader><leader>gs <Esc>:DiffviewOpen<CR>
nnoremap <silent> <leader><leader>gl <Esc>:DiffviewFileHistory<CR>
nnoremap <silent> <leader><leader>gc <Esc>:DiffviewFileHistory %<CR>
nnoremap <silent> <leader><leader>gd <Esc>:execute 'DiffviewFileHistory ' . expand('%:h')<CR>
xnoremap <silent> <leader><leader>gl :DiffviewFileHistory<CR>
nnoremap <silent> <leader>gq <Esc>:DiffviewClose<CR>

