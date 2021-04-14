#!/bin/fish

# compatitable with bash
alias unset "set -e"

set OMF_CONFIG_INIT "$OMF_CONFIG/init.fish"

# for fish config
alias refish ". $OMF_CONFIG_INIT"
alias vifish "vim $OMF_CONFIG_INIT"
alias cafish "cat $OMF_CONFIG_INIT"

source $OMF_CONFIG/custom-alias

# enable vi-mode
fish_vi_key_bindings

# download missing plugins or themes
omf install

# load .profile
fenv source ~/.profile

# use nvm
function nvm
    bass source $HOME/.nvm/nvm.sh --no-use ';' nvm $argv
end
