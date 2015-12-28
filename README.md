doot.git
============
Dotfiles for: bash, screen, emacs, tmux
The master branch corresponds to the Linux version of the dotfiles. If running
Mac OSX, then switch to the mac branch. To be installed with 'setup.sh' in the
'setup.git' repository, which installs prerequisite programs. Alternatively,
clone and run this on a Linux setup to configure your development environment
as follows:

**1) Install git  and add keys**
```sh
cd $HOME
git clone https://github.com/majoranaa/doot.git
ln -sb dotfiles/screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
on -sb dotfiles/.bash_logout .
mv .emacs.d .emacs.d~
ln -s dotfiles/.emacs.d .
```

See also http://github.com/majoranaa/setup to install prerequisite programs. If
all goes well, in addition to a more useful prompt, now you can execute
`emacs hello.js` and hit `C-c!` to launch an interactive SSJS REPL, among many
other features.
