#!/bin/sh

# before running this script, make sure your terminal proxy is configed correctly
# (including http[s]_proxy env variable ,apt, curl and git etc)
set -e

mkdir -p ~/downloads
cd ~/downloads || exit

# APT install
# sudo apt install -y yadm zsh silversearcher-ag

# config dotfiles
yadm clone https://github.com/moukayz/dotfiles.git

# linuxbrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh -o- | bash
brew bundle --global

# zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# mv ~/.zshrc.pre-on-my-zsh ~/.zshrc

# oh-my-fish
curl -sSLf -o- https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# Nvim
curl -fsSL -o nvim-linux.tar.gz "https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz"
tar -xf nvim-linux.tar.gz -C nvim-linux
sudo cp -rf nvim-linux/* /usr/
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 100

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install node
