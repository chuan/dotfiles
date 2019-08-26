#!/usr/bin/env bash

source $(dirname $(which $0))/env.sh

main() {
  set -o errexit
  echo "Installing packages..."
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y) install;;
    *) ;;
  esac

  echo "Configuring zsh..."
  config_zsh

  echo "Configuring tmux..."
  config_tmux

  echo "Configuring vim..."
  config_vim

  echo "Configuring emacs..."
  config_emacs

  echo "Configuring alacritty..."
  config_alacritty

  echo "Done."
}

install() {
  case $(_os) in
    macos) install_mac ;;
    debian) install_linux ;;
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

config_alacritty() {
  if [[ $(_os) == macos ]]; then
    mkdir -p $XDG_CONFIG_HOME/alacritty && \
      ln -f -s ${DOTFILES_DIR}/alacritty.yml $XDG_CONFIG_HOME/alacritty
  fi
}

install_linux() {
  sudo apt-get update && sudo apt-get -y upgrade
  sudo apt-get -y install aptitude
  sudo aptitude -y install fd-find ripgrep zsh tmux vim

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

config_zsh() {
  if [[ ! -d $HOME/.antigen/bundles/zsh-users/antigen ]]; then
    mkdir -p $HOME/.antigen/bundles/zsh-users/antigen
    git clone https://github.com/zsh-users/antigen.git $HOME/.antigen/bundles/zsh-users/antigen
  fi
  ln -f -s ${DOTFILES_DIR}/.zshrc ${HOME}
}

config_tmux() {
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

config_emacs() {
  if [[ ! -d $HOME/.emacs.d ]]; then
    git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
    echo "Run the following command to setup doom:"
    echo "~/.emacs.d/bin/doom -i quickstart"
  fi
}

main "$@"
