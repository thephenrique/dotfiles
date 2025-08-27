#
# Use Oh My Zsh.
#

export ZSH=~/.oh-my-zsh

# ZSH_THEME="robbyrussell"
# ZSH_THEME="wedisagree"
ZSH_THEME="gnzh"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-fzf-history-search
)

source $ZSH/oh-my-zsh.sh

# Load Shell aliases
[ -f "$HOME/.config/zsh/aliases" ] && source "$HOME/.config/zsh/aliases"

# `zsh-fzf-history-search` configs
ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1

# PATH Environment variableas.

alias git-next="~/.config/bin/git-next.sh"

# Add Go programming language.
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:/usr/local/go/bin/bin
export GOPATH=/usr/local/go/bin

# Add Zig programming language.
export PATH=$PATH:/usr/local/zig

# Add Doom Emacs. ¯\_(ツ)_/¯
export PATH=$PATH:$HOME/.emacs.d/bin:$HOME/.config/emacs/bin

# Add ranger file manager.
# Install: `git clone https://github.com/ranger/ranger.git /usr/local/ranger`
alias ranger="python3 /usr/local/ranger/ranger.py"

# Current work PATH Environment variables.

# Add Gympass josie.
export PATH=$PATH:$HOME/.josie

# Add GPG for GitHub.
export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="/home/pedrosilva/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Improve `M-w` (just notes).
x-copy-region-as-kill () {
  zle copy-region-as-kill
  print -rn -- $CUTBUFFER | xclip -selection clipboard
}
zle -N x-copy-region-as-kill
bindkey -e '\ew' x-copy-region-as-kill
