#!/usr/bin/env bash

source $(dirname $(which $0))/env.sh

main() {
  set -o errexit
  echo "Installing the following programming languages:"
  echo "  - Go"
  echo "  - Rust"
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y) install_golang ;;
    *) exit 0 ;;
  esac
}

install_golang() {
  case $(_os) in
    macos)
      brew ls --version golang || brew install golang
      ;;
    debian)
      sudo aptitude install -y golang-1.12
      ;;
  esac
  go get -u golang.org/x/tools/gopls
}

install_rust() {
  curl https://sh.rustup.rs -sSf | sh
}

main "$@"
