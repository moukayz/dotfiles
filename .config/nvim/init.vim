" setup vim config directory(neovim is '$HOME/.config/nvim', vim is '$HOME/.vimrc')
" Note ~/.vimrc is just a symlink to ~/.config.nvim/init.vim

let $VIM_CONFIG_DIR = expand("$HOME/.config/nvim")
let $VIM_PLUGIN_CONFIG_DIR = $VIM_CONFIG_DIR . "/plug-config"
let $SHELL="bash"

source $VIM_CONFIG_DIR/basic.vim
source $VIM_CONFIG_DIR/maps.vim
source $VIM_CONFIG_DIR/terminal.vim

let g:vimrc_loaded = v:true
