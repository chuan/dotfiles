#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${SCRIPT_DIR}/env.sh

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
             sudo aptitude install -y alacritty emacs plantuml hunspell
             ;;
           arch)
             sudo pacman -S alacritty emacs noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-roboto ttf-roboto-mono
             ;;
           *) give_up ;;
         esac ;;
    *) exit 0 ;;
  esac

  echo "Configuring alacritty..."
  config_alacritty

  echo "Configuring emacs..."
  config_emacs

  echo "Configuring environment variables..."
  config_pam_env

  echo "Configuring fonts..."
  config_fonts
}

config_emacs() {
  ln -f -s ${DOTFILES_DIR}/.doom.d ${HOME}
  if [[ ! -d $HOME/.emacs.d ]]; then
    git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
    git -C $HOME/.emacs.d checkout develop
    $HOME/.emacs.d/bin/doom install
  fi
}

config_alacritty() {
  mkdir -p $XDG_CONFIG_HOME/alacritty && \
    ln -f -s ${DOTFILES_DIR}/alacritty.yml $XDG_CONFIG_HOME/alacritty
}

config_pam_env() {
  ln -f -s ${DOTFILES_DIR}/.pam_environment ${HOME}
}

config_fonts() {
  mkdir -p $XDG_CONFIG_HOME/fontconfig && \
    ln -f -s ${DOTFILES_DIR}/fonts.conf $XDG_CONFIG_HOME/fontconfig
}

main "$@"
