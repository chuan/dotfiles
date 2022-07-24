export EDITOR="vim"
export BAT_THEME="Nord"

source ~/.zplug/init.zsh
zplug "yous/vanilli.sh"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search"
zplug load


alias rsync="rsync -avz"

rg() {
  command rg -p "$@" | less -RFX
}

bindkey -e

case "$OSTYPE" in
  darwin*)
    export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
    alias ls="ls -G -H"
    ;;
  linux*)
    alias ls="ls --color=auto"
    ;;
esac

[ -f $HOME/.work.zsh ] && source $HOME/.work.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
