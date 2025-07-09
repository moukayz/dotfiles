#!/usr/bin/env bash

[[ -f ~/.profile ]] && source ~/.profile

[[ -f ~/.bashrc  ]] && source ~/.bashrc
export PATH=/Users/bytedance/.local/bin:$PATH

[ -f "$HOME/.profile" ] && . "$HOME/.profile"

. "$HOME/.cargo/env"
export PATH="/opt/usr/bin:/opt/usr/sbin:$PATH"
