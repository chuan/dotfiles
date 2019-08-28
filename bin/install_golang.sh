#!/usr/bin/env bash

source $(dirname $(which $0))/env.sh

main() {
  set -o errexit
  echo "Installing golang:"
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y) case $(_os) in
           macos)
             brew ls --version golang || brew install golang
             ;;
           debian)
             sudo aptitude install -y golang-1.12
             ;;
         esac ;;
    *) exit 0 ;;
  esac

  go get -u golang.org/x/tools/gopls
}

main "$@"
