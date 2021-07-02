#!/usr/bin/env bash

readonly CUSTOM_CONFIG_HOME="${HOME}/.config/moukayz"

# load bash prompt
source "$HOME"/.bash.prompt

[[ -f "$CUSTOM_CONFIG_HOME/custom_alias" ]] && source "$CUSTOM_CONFIG_HOME/custom_alias"
