**Install Alacritty**

```sh
# Get Alacritty.
git clone https://github.com/alacritty/alacritty.git
cd alacritty

rustup override set stable
rustup update stable

# Build.
echo $XDG_SESSION_TYPE # should return: x11
cargo build --release --no-default-features --features=x11

# Check.
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
infocmp alacritty

# Install.
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
```

**Set default Terminal Emulator**

```sh
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/alacritty 50
sudo update-alternatives --config x-terminal-emulator
```
