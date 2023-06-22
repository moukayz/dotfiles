#!/bin/bash

# before running this script, make sure your terminal proxy is configed correctly
# (including http[s]_proxy env variable ,apt, curl and git etc)
set -eu

# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

function info_log {
  printf "${CYAN}==> %s${NOCOLOR}\n" "$*"
}

function error_log {
  printf "${RED}==x %s${NOCOLOR}\n" "$*"
}

function warn_log {
  printf "${YELLOW}==x %s${NOCOLOR}\n" "$*"
}

function command_exists {
  command -v "$1" &>/dev/null
  return "$?"
}

readonly BREW_BIN="/home/linuxbrew/.linuxbrew/bin"
readonly LOCAL_DIR="${HOME:-~}"/.local
readonly LOCAL_BIN="${LOCAL_DIR}"/bin
mkdir -p "$LOCAL_BIN"

rm -rf /tmp/downloads && mkdir -p /tmp/downloads
cd /tmp/downloads || exit

# yadm
info_log "Installing yadm..."
if command_exists yadm; then
  warn_log "yadm already installed; Skip!"
else
  curl -fsSLo "$LOCAL_BIN"/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x "$LOCAL_BIN"/yadm
fi

info_log "Cloning dotfiles"
"$LOCAL_BIN"/yadm clone -f https://github.com/moukayz/dotfiles.git
# overwrite original files(eg. ~/.profile)
"$LOCAL_BIN"/yadm checkout "$HOME"

# linuxbrew
if command_exists brew; then
  info_log "Installing homebrew..."
  /usr/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  info_log "Setup homebrew environment variables..."
  [[ -d "$BREW_BIN" ]] && eval "$($BREW_BIN/brew shellenv)"

  set +e # not exit even if some brew packages not installed successfully
  info_log "Installing missing brew packages..."
  brew install gcc # install brew dependencies
  brew bundle --global
  set -e
else
  warn_log "brew already installed; Skip!"
fi

# zsh
info_log "Installing oh-my-zsh..."
if command_exists zsh; then
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o omz-install
  # install ohmyzsh without chsh or run zsh, and keep original .zshrc
  sh omz-install --unattended --keep-zshrc
else
  warn_log "zsh not installed; Skip install oh-my-zsh"
fi

# NVM
info_log "Installing npm..."
if type nvm &>/dev/null || [[ -d "${HOME}/.nvm" ]]; then
  warn_log "nvm already installed; Skip!"
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

  # setup nvm environment variables
  NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

  info_log "Installing node using npm..."
  nvm install node
fi

# Nvim
info_log "Installing neovim..."
if [[ -f "${LOCAL_BIN}"/nvim ]]; then
  warn_log "neovim already installed; Skip!"
else
  curl -fsSL -o- "https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz" \
    | tar -xz -C "$LOCAL_DIR" --strip-components=1
  # info_log "[neovim] installing vim-plug..."
  # curl -fsSLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  #     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  info_log "[neovim] Installing nvim plugins..."
  [[ -f "${LOCAL_BIN}"/nvim ]] && "${LOCAL_BIN}"/nvim '+PlugUpdate' '+PlugClean!' '+qall'
fi

# oh-my-fish
info_log "Installing fish omf..."
if command_exists fish; then
  curl -sSLf https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install -o omf-install
  fish omf-install --noninteractive
else
  warn_log "fish shell not installed; Skip installing omf"
fi
