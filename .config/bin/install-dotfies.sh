# Initialize and use Dotfiles with Git.
#
# Setup:
# git clone --bare https://github.com/thephenrique/dotfiles.git .dotfiles
#
# git config --global alias.dotfiles "!git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
#
# (Optional)
# If an error like "... 'git' is not a git command" appears, try set the "!git" alias:
# git config --global alias.git '!git'
# Then try again with this command:
# git config --global alias.dotfiles "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
#
# Now the command below should work:
# git dotfiles <git_command>
#
#
#
# Usage:
# git clone --bare https://github.com/thephenrique/dotfiles.git
#
# git dotfiles remote add origin git@github.com:thephenrique/dotfiles.git
# git dotfiles add --all
# git dotfiles <git_command>

if which git >/dev/null; then
  DOTFILES_FILE=~/.dotfiles

  if [ ! -d "$DOTFILES_FILE" ]; then
    # git init --bare ~/.dotfiles.git
    # git config --global alias.dotfiles "!git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
    git config --global alias.git '!git'
    git config --global alias.dotfiles "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
  fi
fi
