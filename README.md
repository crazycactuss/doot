doot.git
============
Dotfiles for: bash, screen, emacs, tmux

The master branch contains dotfiles that should work for both Linux and Mac
OSes. It detects the OS via `uname`. This repository should be installed with
'setup.sh' in the 'setup.git' repository, which installs prerequisite programs.
Alternatively, clone and run this manually to configure your development
environment as follows:

**1) Install [git](http://git-scm.com/downloads) and add keys**

**2) Execute:**
```sh
cd $HOME
git clone https://github.com/majoranaa/doot.git
ln -sb doot/.screenrc .
ln -sb doot/.bash_profile .
ln -sb doot/.bashrc .
ln -sb doot/.bash_logout .
ln -sb doot/.tmux.conf .
mv .emacs.d .emacs.d~
ln -s doot/.emacs.d .
```

**3) Install emacs MELPA packages**
By default, the following are required:
* auto-complete
* irony-mode (requires additional setup. Refer to init.el)
* iedit
* flymake-google-cpplint
* flymake-cursor
* google-c-style

Optionally, you can install (and uncomment corresponding configuration in
init.el):
* company
* company-irony
* auto-complete-c-headers
* yasnippet

NOTE: For autocompletion you can choose to use auto-complete + CEDET/irony-mode
(with catches) or company + irony-mode. irony-mode should be faster because of
clang.

These packages must be installed. Otherwise, emacs will run into require errors
upon startup. Alternatively, you can comment those requires out. All MELPA
packages are handled under the MELPA heading in the initialization file. Refer
to .emacs.d/init.el for more information on how to install emacs packages via
MELPA. This package installation could be accomplished using a script that's
executed during setup.sh but it's probably better to do it manually to better
understand what's going on.

See also http://github.com/majoranaa/setup to install prerequisite programs. If
all goes well, in addition to a more useful prompt, now you can execute
`emacs hello.js` and hit `C-c!` to launch an interactive SSJS REPL, among many
other features.

Based on https://github.com/startup-class/dotfiles