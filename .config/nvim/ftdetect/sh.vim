""" enable syntax for local bash config file
augroup SetBashFileType
    autocmd!
    autocmd BufRead,BufNewFile,BufEnter .bash.* set filetype=sh
augroup END

