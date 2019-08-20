export EDITOR="vim"

source $HOME/.antigen/antigen.zsh
# Prompt
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
# Useful tools from zsh-users
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search
# Fuzzy dir jump
antigen bundle rupa/z
# End of plugins
antigen apply

rg() {
  command rg -p "$@" | less -RFX
}

bindkey -e

case "$OSTYPE" in
  darwin*)
    export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
    alias ls="ls -G"
    ;;
  linux*)
    alias ls="ls --color=auto"
    alias fd="fdfind"
    ;;
esac

[ -d $HOME/.cargo/bin ] && export PATH="$HOME/.cargo/bin:$PATH"

[ -f $HOME/.work.zsh ] && source $HOME/.work.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
