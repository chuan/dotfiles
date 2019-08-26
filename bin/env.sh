#!/usr/bin/env bash

export XDG_CACHE_HOME=~/.cache
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share
export XDG_BIN_HOME=~/.local/bin

export DOTFILES_BIN="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
export DOTFILES_DIR="$(cd "$DOTFILES_BIN/.." &>/dev/null && pwd)"
export DOTFILES_DATA="$XDG_DATA_HOME/dotfiles"

function _os {
  case $OSTYPE in
    linux*) if   [[ -f /etc/arch-release   ]]; then echo arch
            elif [[ -f /etc/debian_version ]]; then echo debian
            fi ;;
    darwin*) echo macos ;;
    *) echo unknown ;;
  esac
}
