Doot
=========

Dotfiles for: bash, emacs, tmux

The master branch contains dotfiles that should work for both Linux and Mac OSes. It detects the OS
via `uname`. To set up a new system, run the following commands:

**1) Install [homebrew](https://brew.sh)**

**2) Install [git](http://git-scm.com/downloads) and add keys to Github**

**3) Configure git
```sh
git config --global user.name <your_user_name>
git config --global user.email <your_user_email>
git config --global --bool pull.rebase true
git config --global push.default current
```

**3) Execute:**
```sh
cd $HOME
git clone https://github.com/majoranaa/doot.git
ln -sb doot/.bash_profile .
ln -sb doot/.bashrc .
ln -sb doot/.bash_logout .
ln -sb doot/.tmux.conf .
# Assuming you have Hammerspoon installed
ln -sb doot/.hammerspoon/init.lua .hammerspoon/init.lua
mv .emacs.d .emacs.d~
ln -s doot/.emacs.d .
# If on mac
ln -sb doot/vscode/settings.json ~/Library/Application\ Support/Code/User/
ln -sb doot/vscode/keybindings.json ~/Library/Application\ Support/Code/User/
ln -sb doot/.config/flake8 ~/.config/flake8
ln -sb doot/.config/yapf/style ~/.config/yapf/style
```
