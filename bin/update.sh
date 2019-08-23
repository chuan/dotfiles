#!/usr/bin/env bash

BIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

main() {
  set -o errexit
  echo "Updating packages..."
  read -p "Proceed? [y/N] : " yn
  case $yn in
    Y|y) update;;
    *) ;;
  esac

  echo "Self updating..."
  pushd ${BIN_DIR}/..
  git pull
  popd

  echo "Updating zsh..."
  zsh -i -c "antigen update"
  zsh -i -c "antigen selfupdate"

  echo "Updating vim..."
  vim +'PlugUpdate --sync' +qa
  vim +'PlugUpgrade --sync' +qa
}

update() {
  UNAME=$(uname | tr "[:lower:]" "[:upper:]")

  case $UNAME in
    DARWIN) update_mac ;;

    LINUX)
      DISTRO=$(cat /etc/os-release | grep ^ID= | cut -d '=' -f 2)
      case $DISTRO in
        ubuntu) update_linux ;;
        *) give_up ;;
      esac
      ;;

    *) give_up ;;
  esac
}

give_up() {
  echo "Unsupported OS '$UNAME' - '$DISTRO'"
  exit 1
}

update_mac() {
  brew update && brew upgrade
}

update_linux() {
  sudo aptitude update && sudo aptitude upgrade
}

main "$@"
