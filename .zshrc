export ZSH="$HOME/.oh-my-zsh"

# Awesome editor.
alias vim="nvim"
export EDITOR="nvim"
export VISUAL="nvim"
# zsh.
export ZSH_THEME="easy"

plugins=(
  git
  zsh-syntax-highlighting
  fzf
)

source $ZSH/oh-my-zsh.sh

# Binds

# tmux.
# Open tmux sessions with fuzzy finder.
tmux_sessionizer_widget() {
  BUFFER="~/.config/bin/tmux-sessionizer $BUFFER"
  zle accept-line
}
zle -N tmux_sessionizer_widget

bindkey '^F' tmux_sessionizer_widget
bindkey '^G' fzf-history-widget

# Add backward-kill-word to <C-H> and <Backspace>.
bindkey '^H' backward-kill-word
