#!/bin/fish

# compatitable with bash
alias unset "set -e"

# for fish config
alias refish ". $OMF_CONFIG/init.fish"
alias vifish "vim $OMF_CONFIG/init.fish"

source $OMF_CONFIG/custom-alias

# enable vi-mode
fish_vi_key_bindings
