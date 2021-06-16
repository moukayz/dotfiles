" setup vim config directory(neovim is '$HOME/.config/nvim')
let g:vim_config_dir = fnamemodify($MYVIMRC, ":p:h")
let $VIM_CONFIG_DIR = g:vim_config_dir
let $VIM_PLUGIN_CONFIG_DIR = g:vim_config_dir . "/plug-config"

source $VIM_CONFIG_DIR/basic.vim
source $VIM_CONFIG_DIR/maps.vim
