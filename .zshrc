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
# Grep only failed files from large project.
alias testfailfiles="yarn jest --silent 2>&1 | grep 'FAIL' | sort | uniq"

# Monitor settings.
# xrandr --listactivemonitors

LAPTOP_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-1"

# Setup external primary monitor.
alias sethdmi="xrandr --output $EXTERNAL_MONITOR --primary --right-of $LAPTOP_MONITOR"
# Turn on/off laptop monitor (right|left*).
alias setnoteon="xrandr --output $LAPTOP_MONITOR --left-of $EXTERNAL_MONITOR --auto"
alias setnoteoff="xrandr --output $LAPTOP_MONITOR --off"

# Initialize Dotfiles with Git.
if which git >/dev/null; then
  return # ... skip.

  DOTFILES_FILE=~/.dotfiles.git

  if [ ! -d "$DOTFILES_FILE" ]; then
    git init --bare ~/.dotfiles.git
    git config --global alias.dotfiles "!git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"

    # git clone --bare https://github.com/thephenrique/dotfiles.git
    # git clone https://github.com/thephenrique/dotfiles.git
    #
    # git dotfiles remote add origin git@github.com:thephenrique/dotfiles.git
    # git dotfiles add .
    # git dotfiles commit ...
  fi
fi

