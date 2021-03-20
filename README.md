# Dotfiles

```sh
git clone https://github.com/illotum/dotfiles.git $HOME/.dotfiles
alias y='/usr/bin/git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME'
y --local status.showUntrackedFiles no
y checkout

# Install Homebrew.
brew bundle
./.macos
sudo vi /etc/shells # /usr/local/bin/fish
chsh -s /usr/local/bin/fish
```
