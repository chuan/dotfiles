#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${SCRIPT_DIR}/env.sh

main() {
  set -o errexit
  echo "Installing packages..."
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y) install;;
    *) exit 0 ;;
  esac

  echo "Configuring zsh..."
  config_zsh

  echo "Configuring tmux..."
  config_tmux

  echo "Configuring vim..."
  config_vim

  echo "Done."
}

install() {
  case $(_os) in
    macos) install_mac ;;
    debian) install_debian ;;
    arch) install_arch ;;
    *) give_up ;;
  esac
}

give_up() {
  echo "Unsupported OS."
  exit 1
}

install_mac() {
  # Install Homebrew.
  if test ! $(which brew); then
    echo "Installing Homebrew (https://brew.sh/)"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  # Update Homebrew.
  brew update
  # Install packages.
  brew ls --versions coreutils || brew install coreutils
  brew ls --versions bat || brew install bat
  brew ls --versions fd || brew install fd
  brew ls --versions ripgrep || brew install ripgrep
  brew ls --versions zsh || brew install zsh
  brew ls --versions tmux || brew install tmux
  brew ls --versions macvim || brew install macvim
  brew ls --versions editorconfig || brew install editorconfig
}

install_debian() {
  sudo apt-get update && sudo apt-get -y upgrade
  sudo apt-get -y install aptitude
  sudo aptitude -y install fd-find ripgrep zsh tmux vim editorconfig

  BAT_LATEST_VERSION=0.11.0
  BAT_INSTALLED_VERSION=$(dpkg-query -W bat 2>/dev/null | awk '{ print $2 }')
  if [[ "${BAT_INSTALLED_VERSION}" < "${BAT_LATEST_VERSION}" ]]; then
    BAT_PKG=bat_${BAT_LATEST_VERSION}_amd64.deb
    wget https://github.com/sharkdp/bat/releases/download/v${BAT_LATEST_VERSION}/${BAT_PKG}
    sudo dpkg -i ${BAT_PKG}
    rm -f ${BAT_PKG}
  else
    echo "bat ${BAT_INSTALLED_VERSION} is already installed. Skipping..."
  fi
}

install_arch() {
  sudo pacman -Syu
  sudo pacman -S fd ripgrep bat zsh tmux vim editorconfig-core-c
}


config_zsh() {
  if [[ ! -d $HOME/.antigen/bundles/zsh-users/antigen ]]; then
    mkdir -p $HOME/.antigen/bundles/zsh-users/antigen
    git clone https://github.com/zsh-users/antigen.git $HOME/.antigen/bundles/zsh-users/antigen
  fi
  ln -f -s ${DOTFILES_DIR}/.zshrc ${HOME}
  ln -f -s ${DOTFILES_DIR}/.zprofile ${HOME}
}

config_tmux() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ln -f -s ${DOTFILES_DIR}/.tmux.conf ${HOME}
}

config_vim() {
  if [[ ! -f  ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  ln -f -s ${DOTFILES_DIR}/.vimrc ${HOME}
  vim +'PlugInstall --sync' +qa
}

main "$@"
