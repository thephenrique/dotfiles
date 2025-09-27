# zsh + Oh My Zsh

Just the necessary. \ (•◡•) /

## Install

### Install zsh (Debian/Ubuntu)

```sh
apt install zsh
```

### Install Oh My Zsh

```sh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```

### Install zsh plugins

```sh
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-fzf-history-search
git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
```

Load custom Oh My Zsh theme.

```sh
ln -s ~/.config/zsh/themes/easy.zsh-theme $ZSH_CUSTOM/themes/easy.zsh-theme
```
