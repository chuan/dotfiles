
case "$OSTYPE" in
  darwin*)
    export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
    alias ls="ls -G"
    source /usr/local/Cellar/fzf/0.18.0/shell/completion.zsh
    source /usr/local/Cellar/fzf/0.18.0/shell/key-bindings.zsh
    source /usr/local/share/antigen/antigen.zsh
    ;;
  linux*)
    alias ls="ls --color=auto"
    source /usr/share/zsh/vendor-completions/_fzf
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source $HOME/.antigen/antigen.zsh
    ;;
esac
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

