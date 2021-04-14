#!/usr/bin/env fish

# compatitable with bash
alias unset "set -e"

set OMF_CONFIG_INIT "$OMF_CONFIG/init.fish"

# download missing plugins or themes
omf install

# for fish config
alias refish ". $OMF_CONFIG_INIT"
alias vifish "vim $OMF_CONFIG_INIT"
alias cafish "cat $OMF_CONFIG_INIT"

source $OMF_CONFIG/custom-alias

# enable vi-mode
function fish_user_key_bindings
    fish_default_key_bindings -M insert

    fzf_key_bindings

    fish_vi_key_bindings --no-erase insert
    set -gx fish_cursor_default block
    set -gx fish_cursor_insert line
    set -gx fish_cursor_replace underscore
end
fish_user_key_bindings

# load .profile
fenv source ~/.profile

# use nvm
function nvm
    bass source $HOME/.nvm/nvm.sh --no-use ';' nvm $argv
end
