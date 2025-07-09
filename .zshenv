[[ -f ~/.profile ]] && source ~/.profile

[[ -f ~/.env.work ]] && source ~/.env.work
. "$HOME/.cargo/env"
export PATH="/opt/usr/bin:/opt/usr/sbin:$PATH"
