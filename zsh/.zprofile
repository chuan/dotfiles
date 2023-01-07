[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

export LIBRARY_PATH="$(xcrun --show-sdk-path)/usr/lib:$(brew --prefix)/lib"

