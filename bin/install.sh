#!/usr/bin/env bash

main() {
  set -o errexit

  echo "Configuring zsh..."
  config_zsh

  echo "Configuring tmux..."
  config_tmux

  echo "Configuring vim..."
  config_vim

  echo "Configuring alacritty..."
  config_alacritty

  echo "Configuring emacs..."
  config_emacs

  echo "Done."
}

install() {
  if [[ $# -eq 0 ]]; then
    echo "Incorrect install command."
    exit 1
  fi
  package=$1
  target=${HOME}
  if [[ $# -eq 2 ]]; then
    target=${HOME}/$2
  fi
  pushd ${DOTFILES_DIR}
  stow --target=${target} ${package}
  popd
}

config_zsh() {
  if [[ ! -d $HOME/.antigen/bundles/zsh-users/antigen ]]; then
    mkdir -p $HOME/.antigen/bundles/zsh-users/antigen
    git clone git@github.com:zsh-users/antigen.git $HOME/.antigen/bundles/zsh-users/antigen
  fi
  install zsh
  ${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh
}

config_tmux() {
  if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
    mkdir -p $HOME/.tmux/plugins/tpm
    git clone git@github.com:tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
  install tmux
}

config_vim() {
  if [[ ! -f  ~/.vim/autoload/plug.vim ]]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
  install vim
  vim +'PlugInstall --sync' +qa
}

config_emacs() {
  if [[ ! -d $HOME/.doom.d ]]; then
    mkdir $HOME/.doom.d
    install doom .doom.d
  fi

  if [[ ! -d $HOME/.emacs.d ]]; then
    git clone git@github.com:hlissner/doom-emacs $HOME/.emacs.d
    $HOME/.emacs.d/bin/doom install
  fi
}

config_alacritty() {
  mkdir -p $HOME/.config/alacritty && \
    install alacritty .config/alacritty
}

main "$@"
