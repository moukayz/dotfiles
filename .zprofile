#!/usr/bin/env zsh

# load general shell configs
COMMON_PROFILE="${HOME}/.profile"
CUSTOM_CONFIG_HOME="${HOME}/.config/moukayz"
CUSTOM_ALIAS="${CUSTOM_CONFIG_HOME}/custom_alias"

[[ -f "$COMMON_PROFILE" ]] && source "$COMMON_PROFILE"

[[ -f "$CUSTOM_ALIAS" ]] && source "$CUSTOM_ALIAS"
