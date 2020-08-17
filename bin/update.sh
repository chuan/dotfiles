#!/usr/bin/env bash

source $(dirname $(which $0))/env.sh

main() {
  set -o errexit
  echo "Updating packages..."
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y) update;;
    *) ;;
  esac

  echo "Self updating..."
  git -C ${DOTFILES_DIR} pull

  echo "Updating zsh..."
  zsh -i -c "antigen update"
  zsh -i -c "antigen selfupdate"

  echo "Updating vim..."
  vim +'PlugUpdate --sync' +qa
  vim +'PlugUpgrade --sync' +qa

  if [[ -d $HOME/.emacs.d ]]; then
    echo "Updating emacs..."
    git -C $HOME/.emacs.d pull
    $HOME/.emacs.d/bin/doom sync
  fi
}

update() {
  case $(_os) in
    macos) update_mac ;;
    debian) update_debian ;;
    arch) update_arch ;;
    *) give_up ;;
  esac
}

give_up() {
  echo "Unsupported OS"
  exit 1
}

update_mac() {
  brew update && brew upgrade
}

update_debian() {
  sudo aptitude update && sudo aptitude upgrade
}

update_arch() {
  sudo pacman -Syu
}


main "$@"
