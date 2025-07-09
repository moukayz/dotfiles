#!/usr/bin/env bash

readonly CUSTOM_CONFIG_HOME="${HOME}/.config/moukayz"

# load bash prompt
source "$HOME"/.bash.prompt

[[ -f "$CUSTOM_CONFIG_HOME/custom_alias" ]] && source "$CUSTOM_CONFIG_HOME/custom_alias"
export PATH=/Users/bytedance/.local/bin:$PATH
. "$HOME/.cargo/env"

# Enable menu completion (cycle through candidates with Tab)
bind "TAB: menu-complete"
# Enable case-insensitive completion (optional, but useful)
shopt -s nocaseglob
