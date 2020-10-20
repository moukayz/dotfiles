set runtimepath+=~/.vim_runtime

"source ~/.vim_runtime/vimrcs/basic.vim
"source ~/.vim_runtime/vimrcs/filetypes.vim
"source ~/.vim_runtime/vimrcs/plugins_config.vim
"source ~/.vim_runtime/vimrcs/extended.vim

try
"source ~/.vim_runtime/my_configs.vim
catch
endtry

filetype plugin on 
set path+=**
set showcmd
set number
set relativenumber
set autoread
set autoindent
set cursorline
syntax on
set syntax+=whitespace
set conceallevel=2
set concealcursor
