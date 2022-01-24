Doot
=========

Remember to refer to "Terminal Setup Instructions" note for further MacOS setup.

# Create symlinks

```sh
cd $HOME
git clone https://github.com/majoranaa/doot.git
ln -s $HOME/doot/.condarc .
ln -s $HOME/doot/.emacs.d .
ln -s $HOME/doot/.tmux.conf .
ln -s $HOME/doot/.zprofile .
ln -s $HOME/doot/.zshrc .

# If on MacOS
mkdir -p .config/yapf
ln -s $HOME/doot/.config/flake8 ~/.config
ln -s $HOME/doot/.config/yapf/style ~/.config/yapf
mkdir -p .hammerspoon
ln -s $HOME/doot/.hammerspoon/init.lua .hammerspoon
ln -s $HOME/doot/vscode/settings.json ~/Library/Application\ Support/Code/User
ln -s $HOME/doot/vscode/keybindings.json ~/Library/Application\ Support/Code/User
```
