#!/bin/sh

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"

# Created by `userpath` on 2020-07-30 13:04:13
[ -d /home/linuxbrew/.linuxbrew/bin ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -d /usr/local/go/bin ] && PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# Rust path
[ -d "$HOME/.cargo" ] && 
# Load work relative env if exists
[ -f "$HOME/.env.work" ] && source "$HOME/.env.work"

# setup proxy environment variable
# [ -f "$HOME"/enable_proxy ] && . "$HOME"/enable_proxy

# config nvm path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# config fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --follow --exclude .git"
# setup fzf theme
export FZF_DEFAULT_OPTS='--color=fg:#cbccc6,bg:#1f2430,hl:#707a8c --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66 --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'
# setup fzf layout style
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --border --height 40% --reverse --prompt=\"=> \""
[ -f "$HOME/fzf-git.sh" ] && source "$HOME/fzf-git.sh"

# setup default shell editor
if command -v nvim &> /dev/null; then
    export EDITOR="nvim" 
else
    export EDITOR="vim"
fi

[ -d "$HOME/flutter-dev" ] && PATH="$PATH:$HOME/flutter-dev/flutter/bin" && export PUB_HOSTED_URL="https://pub.flutter-io.cn" && export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
[ -f "$HOME/.mboxrc" ] && . "$HOME/.mboxrc"

. "$HOME/.cargo/env"
