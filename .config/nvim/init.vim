" setup vim config directory(neovim is '$HOME/.config/nvim', vim is '$HOME/.vimrc')
" Note ~/.vimrc is just a symlink to ~/.config.nvim/init.vim

let $VIM_CONFIG_DIR = expand("$HOME/.config/nvim")
let $VIM_CONFIG_LUA_DIR = expand("$HOME/.config/nvim/lua/config")
let $SHELL="bash"

" source $VIM_CONFIG_DIR/basic.vim
" lua require('config.basic').setup()
" luafile $VIM_CONFIG_LUA_DIR/basic.lua
lua require('config.basic').setup()
lua require('config.plugins')
lua require('config.color').setup()
" source $VIM_CONFIG_DIR/plugins.vim
" source $VIM_CONFIG_DIR/color.vim
source $VIM_CONFIG_DIR/maps.vim
source $VIM_CONFIG_DIR/terminal.vim

let g:vimrc_loaded = v:true
