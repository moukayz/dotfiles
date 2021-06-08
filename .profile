# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[[ -d "$HOME/.local/bin" ]] && PATH="$PATH:$HOME/.local/bin"

# Created by `userpath` on 2020-07-30 13:04:13
[[ -d /home/linuxbrew/.linuxbrew/bin ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

[[ -d /usr/local/go/bin ]] && PATH="$PATH:/usr/local/go/bin:$HOME/go/bin"

# setup proxy environment variable
[[ -f "$HOME"/enable_proxy ]] && source "$HOME"/enable_proxy

# enable cntlm proxy server
[[ -f "$HOME"/proxy-worker ]] && "$HOME"/proxy-worker

# config nvm path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# config fzf
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# set git alias
alias gs="git status"
alias gss="git status -s"
alias gcm="git commit -m"
alias gca="git commit -am"
alias glo="git log --oneline"
alias gln="git log --name-only"
alias gaa="git add ."
alias gprb="git pull --rebase"
