export ZSH=~/.oh-my-zsh

plugins=(
  git
  # vi-mode
  zsh-vi-mode
  zsh-syntax-highlighting
  fzf
)

# zsh.
export ZSH_THEME="gnzh"
# zsh-vi-mode.
export ZVM_INIT_MODE=sourcing
export ZVM_SYSTEM_CLIPBOARD_ENABLED=true


# Load Shell aliases
[ -f "$HOME/.config/zsh/aliases" ] && source "$HOME/.config/zsh/aliases"

# `zsh-fzf-history-search` configs
# ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
# ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
# ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1

# PATH Environment variableas.

alias git-next="~/.config/bin/git-next.sh"

# Add Go programming language.
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin:/usr/local/go/bin/bin
export GOPATH=/usr/local/go/bin

# Add Zig programming language.
export PATH=$PATH:/usr/local/zig

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
#
source $ZSH/oh-my-zsh.sh

# Conflict between zsh-vi-mode and fzf.
# Replace <C-r> from fzf to Redo of zsh-vi-mode.
bindkey '^R' redo
bindkey -M vicmd '^R' redo
# Set (grep) <C-g> to history fzf.
bindkey '^G' fzf-history-widget
bindkey -M vicmd '^G' fzf-history-widget

# zsh-vi-mode.
# Use system clipboard for pasting.
zvm_bindkey vicmd  'p' zvm_paste_clipboard_after
zvm_bindkey vicmd  'P' zvm_paste_clipboard_before
zvm_bindkey visual 'p' zvm_visual_paste_clipboard
zvm_bindkey visual 'P' zvm_visual_paste_clipboard
