" setup vim config directory(neovim is '$HOME/.config/nvim', vim is '$HOME/.vimrc')
" Note ~/.vimrc is just a symlink to ~/.config.nvim/init.vim

let $VIM_CONFIG_DIR =  "$HOME/.config/nvim"
let $VIM_PLUGIN_CONFIG_DIR = $VIM_CONFIG_DIR . "/plug-config"

source $VIM_CONFIG_DIR/basic.vim
source $VIM_CONFIG_DIR/maps.vim
