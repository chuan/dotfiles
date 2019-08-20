if [[ -f /usr/local/share/antigen/antigen.zsh ]]; then
    source /usr/local/share/antigen/antigen.zsh
elif [[ -f $HOME/.antigen/antigen.zsh ]]; then
    source $HOME/.antigen/antigen.zsh
fi

bindkey -e

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

if [[ -d ~/.fzf/shell ]]; then
  . ~/.fzf/shell/completion.zsh
  . ~/.fzf/shell/key-bindings.zsh
else
  [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]] && . /usr/share/doc/fzf/examples/key-bindings.zsh
  [[ -f /usr/share/zsh/vendor-completions/_fzf ]] && . /usr/share/zsh/vendor-completions/_fzf
fi

rg() {
  command rg -p "$@" | less -RFX
}

alias ls="ls --color=auto"
