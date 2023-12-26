# Initialize Dotfiles with Git.
#
# Usage:
# git clone --bare https://github.com/thephenrique/dotfiles.git
# git clone https://github.com/thephenrique/dotfiles.git
#
# git dotfiles remote add origin git@github.com:thephenrique/dotfiles.git
# git dotfiles add .
# git dotfiles commit ...

if which git >/dev/null; then
  DOTFILES_FILE=~/.dotfiles.git

  if [ ! -d "$DOTFILES_FILE" ]; then
    git init --bare ~/.dotfiles.git
    git config --global alias.dotfiles "!git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
  fi
fi
