export ZSH="$HOME/.oh-my-zsh"

# Awesome editor.
alias vim="nvim"
export EDITOR="nvim"
export VISUAL="nvim"

plugins=(
  git
  #vi-mode
  zsh-vi-mode
  zsh-syntax-highlighting
  fzf
)

# Variables

# zsh.
export ZSH_THEME="gnzh"
# zsh-vi-mode.
export ZVM_INIT_MODE=sourcing
export ZVM_SYSTEM_CLIPBOARD_ENABLED=true

source $ZSH/oh-my-zsh.sh

# Binds

# tmux.
# Open tmux sessions with fuzzy finder.
bindkey -s '^f' '~/.config/bin/tmux-sessionizer\n'

# Conflict between zsh-vi-mode and fzf.
# Replace <C-r> from fzf to Redo of zsh-vi-mode.
bindkey '^R' redo
bindkey -M vicmd '^R' redo
# Set (grep) <C-g> to history fzf.
bindkey '^G' fzf-history-widget
bindkey -M vicmd '^G' fzf-history-widget

# zsh-vi-mode.
# Use wl-clipboard no Wayland.
export ZVM_CLIPBOARD_COPY_CMD='wl-copy'
export ZVM_CLIPBOARD_PASTE_CMD='wl-paste -n'
# Use system clipboard for pasting.
zvm_bindkey vicmd  'p' zvm_paste_clipboard_after
zvm_bindkey vicmd  'P' zvm_paste_clipboard_before
zvm_bindkey visual 'p' zvm_visual_paste_clipboard
zvm_bindkey visual 'P' zvm_visual_paste_clipboard
