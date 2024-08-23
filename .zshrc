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
)

source $ZSH/oh-my-zsh.sh

# Load Shell aliases
[ -f "$HOME/.config/zsh/aliases" ] && source "$HOME/.config/zsh/aliases"

# PATH Environment variableas.

# Add Go programming language.
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:/usr/local/go/bin/bin
export GOPATH=/usr/local/go/bin

# Add Doom Emacs. ¯\_(ツ)_/¯
export PATH=$PATH:$HOME/.emacs.d/bin:$HOME/.config/emacs/bin

# Current work PATH Environment variables.

# Add Gympass josie.
export PATH=$PATH:$HOME/.josie

# Add GPG for GitHub.
export GPG_TTY=$(tty)
