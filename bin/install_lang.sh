#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source ${SCRIPT_DIR}/env.sh

main() {
  set -o errexit
  echo "Installing the following programming languages:"
  echo "  - Go"
  echo "  - Rust"
  echo "  - C++ language server: ccls"
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y)
      install_golang
      install_rust
      ;;
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
    arch)
      sudo pacman -S go
  esac
  go get -u golang.org/x/tools/gopls
}

install_rust() {
  curl https://sh.rustup.rs -sSf | sh
}

main "$@"
