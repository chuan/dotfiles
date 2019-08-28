#!/usr/bin/env bash

source $(dirname $(which $0))/env.sh

main() {
  set -o errexit

  echo "Installing the following GUI applications:"
  echo "  - alacritty"
  echo "  - emacs"
  read -p "Proceed? [y/N] : " gui
  case $gui in
    Y|y) case $(_os) in
           macos)
             brew cask ls --versions alacritty || brew cask install alacritty
             brew cask ls --versions emacs || brew cask install emacs
             ;;
           debian)
             sudo aptitude install -y alacritty emacs
             ;;
           *) give_up ;;
         esac ;;
    *) exit 0 ;;
  esac

  echo "Configuring alacritty..."
  config_alacritty

  echo "Configuring emacs..."
  config_emacs
}

config_emacs() {
  if [[ ! -d $HOME/.emacs.d ]]; then
    git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
    git -C $HOME/.emacs.d checkout develop
    $HOME/.emacs.d/bin/doom quickstart
  fi
}

config_alacritty() {
  if [[ $(_os) == macos ]]; then
    mkdir -p $XDG_CONFIG_HOME/alacritty && \
      ln -f -s ${DOTFILES_DIR}/alacritty.yml $XDG_CONFIG_HOME/alacritty
  fi
}

main "$@"
