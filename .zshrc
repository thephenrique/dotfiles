export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gnzh"

plugins=(
  git
  vi-mode
  fzf
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Editors
alias vim="nvim"
export EDITOR="nvim"
export VISUAL="nvim"

# Binds.

# Open tmux sessions with fuzzy finder.
bindkey -s '^f' '~/.config/bin/tmux-sessionizer\n'
