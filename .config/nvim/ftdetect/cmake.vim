""" Enable syntax for CMakeLists.txt file
augroup CMakeSyntax
    autocmd!
    autocmd BufNewFile,BufRead CMakeLists.txt set filetype=cmake
augroup END

