#!/bin/sh

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$PATH:$HOME/.local/bin"

# Created by `userpath` on 2020-07-30 13:04:13
[ -d /home/linuxbrew/.linuxbrew/bin ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[ -d /usr/local/go/bin ] && PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# setup proxy environment variable
[ -f "$HOME"/enable_proxy ] && . "$HOME"/enable_proxy

# enable cntlm proxy server
[ -f "$HOME"/proxy-worker ] && "$HOME"/proxy-worker

# config nvm path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# config fzf
# when fzf in project folder, use `exec-batch` to sort fd results by mtime
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git -X ls -t"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --follow --exclude .git"
# setup fzf theme
export FZF_DEFAULT_OPTS='--color=fg:#cbccc6,bg:#1f2430,hl:#707a8c --color=fg+:#707a8c,bg+:#191e2a,hl+:#ffcc66 --color=info:#73d0ff,prompt:#707a8c,pointer:#cbccc6 --color=marker:#73d0ff,spinner:#73d0ff,header:#d4bfff'
# setup fzf layout style
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --border --height 40% --reverse --prompt=\"=> \""

# set git alias
alias gs="git status"
alias gss="git status -s"
alias gcm="git commit -m"
alias gca="git commit -am"
alias glo="git log --oneline"
alias gln="git log --name-only"
alias gaa="git add ."
alias gprb="git pull --rebase"

# set yadm alias
alias yss="yadm status -s"
alias yp="yadm push"
alias ya="yadm add"
alias yc="yadm commit -m"
alias yca="yadm commit -am"
