# .bash_profile file
# Courtesy of Balaji S. Srinivasan <balajis@stanford.edu>
#
# FOR BASH TIPS,
# See: http://www.ukuug.org/events/linux2003/papers/bash_tips/
#
# Concepts:
#
# See: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#
#    1) .bashrc is the *non-login* config for bash, run in scripts and after
#        first connection.
#    2) .bash_profile is the *login* config for bash, launched upon first
#        connection (in Ubuntu)
#    3) .bash_profile imports .bashrc in our script, but not vice versa.
#
# When using GNU screen or tmux:
#
#    1) .bash_profile is loaded the first time you login, and should be used
#       only for PATHS and ENVIRONMENT VARIABLES
#    2) .bashrc is loaded in each subsequent window, and should be used for
#       ALIASES and MISC (eg: writing to .bash_eternal_history (see below))
#
# For reference, see `man bashrc` or
# http://en.wikipedia.org/wiki/Bash#Startup_scripts
#
# When Bash starts, it executes the commands in a variety of different scripts.
#
#   1) When Bash is invoked as an interactive login shell, it first reads
#      and executes commands from the file /etc/profile, if that file
#      exists. After reading that file, it looks for ~/.bash_profile,
#      ~/.bash_login, and ~/.profile, in that order, and reads and executes
#      commands from the first one that exists and is readable.
#
#   2) When a login shell exits, Bash reads and executes commands from the
#      file ~/.bash_logout, if it exists.
#
#   3) When an interactive shell that is not a login shell is started
#      (e.g. a GNU screen session), Bash reads and executes commands from
#      ~/.bashrc, if that file exists. This may be inhibited by using the
#      --norc option. The --rcfile file option will force Bash to read and
#      execute commands from file instead of ~/.bashrc.

platform='unknown'
if [ "`uname`" == "Linux" ]; then # Linux OS
    platform='linux'
elif [ "`uname`" == "Darwin" ]; then # Mac OS
    platform='mac'
fi

# Reset PATH if on mac
if [ -x /usr/libexec/path_helper ]; then
    PATH=""
    eval `/usr/libexec/path_helper -s`
fi

## -----------------------
## -- 1) Import .bashrc --
## -----------------------

# Factor out all repeated profile initialization into .bashrc
#  - All non-login shell parameters go there
#  - All declarations repeated for each screen/tmux windows go there
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Configure PATH
#  - These are line by line so that you can kill one without affecting the others.
#  - Lowest priority first, highest priority last.
export PATH="$HOME/bin:$PATH"
if [ "$platform" == "linux" ]; then
    #export PATH="/usr/local/sbin:$PATH"
    export PATH="$PATH"
fi

if [ "$platform" == "mac" ]; then
    # MySQL
    #export PATH="/usr/local/mysql/bin:$PATH"

    # pebble 2.9 stuff
    #export PATH="$HOME/Projects/lahacks_2015/pebble/PebbleSDK-2.9/bin:$PATH"

    # matlab
    export PATH="/Applications/MATLAB_R2016a.app/bin:$PATH"

    # add MAMP bin to path
    #export PATH="$PATH:/Applications/MAMP/Library/bin/mysql"

    # julia
    #export PATH="/Applications/Julia-0.3.7.app/Contents/Resources/julia/bin:$PATH"

    # OPAM (octave pkg manager) configuration
    #. /Users/kaiyang/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

    # PHP 7.1
    export PATH="/usr/local/php5/bin:$PATH"

    # jenv
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"

    # Add Visual Studio Code (code)
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/kaiyang/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/kaiyang/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/kaiyang/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/kaiyang/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
