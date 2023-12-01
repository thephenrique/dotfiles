# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
export EDITOR="nvim"

# Olympus lint automation.
alias olympuslint="yarn lint && yarn check:typescript && yarn test:ci"

# On/Off notebook monitor at (right|left).
alias noteon="xrandr --output eDP-1 --left-of HDMI-1 --auto"
alias noteoff="xrandr --output eDP-1 --off"

# Initialize Dotfiles with Git.
if which git >/dev/null; then
  DOTFILES_FILE=~/dotfiles.git

  if [ ! -d "$DOTFILES_FILE" ]; then
    git init --bare ~/dotfiles.git
    git config --global alias.dotfiles "!git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME"

    # git clone --bare https://github.com/thephenrique/dotfiles.git
    # git clone https://github.com/thephenrique/dotfiles.git
    #
    # git dotfiles remote add origin git@github.com:thephenrique/dotfiles.git
    # git dotfiles add .
    # git dotfiles commit ...
  fi
fi

