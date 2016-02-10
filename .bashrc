# .bashrc file
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
# See: http://en.wikipedia.org/wiki/Bash#Startup_scripts
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

# -----------------------------------
# -- 1.1) Set up umask permissions --
# -----------------------------------
#  The following incantation allows easy group modification of files.
#  See: http://en.wikipedia.org/wiki/Umask
#
#     umask 002 allows only you to write (but the group to read) any new
#     files that you create.
#
#     umask 022 allows both you and the group to write to any new files
#     which you make.
#
#  In general we want umask 022 on the server and umask 002 on local
#  machines.
#
#  The command 'id' gives the info we need to distinguish these cases.
#
#     $ id -gn  #gives group name
#     $ id -un  #gives user name
#     $ id -u   #gives user ID
#
#  So: if the group name is the same as the username OR the user id is not
#  greater than 99 (i.e. not root or a privileged user), then we are on a
#  local machine (check for yourself), so we set umask 002.
#
#  Conversely, if the default group name is *different* from the username
#  AND the user id is greater than 99, we're on the server, and set umask
#  022 for easy collaborative editing.
if [ "`id -gn`" == "`id -un`" -o  `id -u` -le 99 ]; then
    umask 002
else
    umask 022
fi

# ---------------------------------------------------------
# -- 1.2) Set up bash prompt and ~/.bash_eternal_history --
# ---------------------------------------------------------
#  Set various bash parameters based on whether the shell is 'interactive'
#  or not.  An interactive shell is one you type commands into, a
#  non-interactive one is the bash environment used in scripts.
if [ "$PS1" ]; then

    # `tput kbs` returns the character in the terminfo database for the
    # backspace character: ^h. `stty erase <char>` sets <char> as the character
    # for erasing, which is normally ASCII 127: ^?. We set it to ^h temporarily
    # here and reset it to ^? later. For reference,
    # See: https://www.cs.utah.edu/~rdjackso/cgi-bin/blosxom.cgi/computers/linux/redhat
    if [ -x /usr/bin/tput ]; then
	if [ "x`tput kbs`" != "x" ]; then # We can't do this with "dumb" terminal
            [[ $- == *i* ]] && stty erase `tput kbs` # make sure is interactive shell
	elif [ -x /usr/bin/wc ]; then
            if [ "`tput kbs|wc -c `" -gt 0 ]; then # We can't do this with "dumb" terminal
		[[ $- == *i* ]] && stty erase `tput kbs`
            fi
	fi
    fi
    case $TERM in
	xterm*)
	    if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
		PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
	    else
		# See: https://en.wikipedia.org/wiki/ANSI_escape_code
		# \033 is ASCII <ESC>. \007 is ASCII bell (plays audio
		# bell). The \033]0;<text>\007 escape sequence changes the
		# window title to <text>
	    	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
	    fi
	    ;;
	# a window in screen or tmux
	screen)
	    if [ -e /etc/sysconfig/bash-prompt-screen ]; then
		PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
	    else
		# The \033_<text>\033\\ sequence captures <text> and xterm
		# ignores it. We don't want to change the window title if
		# using tmux/screen
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
	    fi
	    # set $WINDOW for tmux
	    WINDOW=${WINDOW:-$(tmux display-message -p '#I')}
	    ;;
	*)
	    [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default

	    ;;
    esac
    if [ "$TERM" == "screen" ] || [ "$TERM" == "xterm" ]; then
    	export TERM="$TERM-256color"
    fi

    # Bash eternal history
    # --------------------
    # This snippet allows infinite recording of every command you've ever
    # entered on the machine, without using a large HISTFILESIZE variable,
    # and keeps track if you have multiple screens and ssh sessions into the
    # same machine. It is adapted from:
    # See: http://www.debian-administration.org/articles/543
    #
    # The way it works is that after each command is executed and
    # before a prompt is displayed, a line with the last command (and
    # some metadata) is appended to ~/.bash_eternal_history.
    #
    # This file is a tab-delimited, timestamped file, with the following
    # columns:
    #
    # 1) user
    # 2) hostname
    # 3) screen window (in case you are using GNU screen or tmux)
    # 4) date/time
    # 5) current working directory (to see where a command was executed)
    # 6) the last command you executed
    #
    # The only minor bug: if you include a literal newline or tab (e.g. with
    # awk -F"\t"), then that will be included verbatime. It is possible to
    # define a bash function which escapes the string before writing it; if you
    # have a fix for that which doesn't slow the command down, please submit
    # a patch or pull request.
    
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo -e $$\\t$USER\\t$HOSTNAME\\tscreen $WINDOW\\t`date +%D%t%T%t%Y%t%s`\\t$PWD"$(history 1)" >> ~/.bash_eternal_history'

    # Turn on checkwinsize (checks LINES and COLUMNS every prompt)
    shopt -s checkwinsize

    if [ "x$SHLVL" != "x1" ]; then # We're not a login shell
	# normally nothing here
        for i in /etc/profile.d/*.sh; do
	    if [ -r "$i" ]; then
	        . $i
	    fi
	done
    fi
fi

# About set & shopt: `help shopt` and `help set` (which are almost the same)
# Normally `shopt -s/-u <option>` or `set -o/+o <option>'. For reference,
# See: https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#The-Set-Builtin
# See: https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html#The-Shopt-Builtin

# Append to history (appends to HISTFILE rather than only keep last HISTSIZE
# lines of in-memory history list). You can interact with the history list
# using `fc` and `history <num_lines>`
# Default HISTFILE: ~/.bash_history, HISTSIZE: 500, HISTFILESIZE: 500
#
# For reference,
# See: https://www.gnu.org/software/bash/manual/html_node/Using-History-Interactively.html#Using-History-Interactively
# See: http://stackoverflow.com/questions/19454837/bash-histsize-vs-histfilesize
# See: http://www.tldp.org/LDP/abs/html/histcommands.html
shopt -s histappend

# Make prompt informative. For reference,
# See: http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
# See: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html
# See: http://www.cyberciti.biz/faq/bash-shell-change-the-color-of-my-shell-prompt-under-linux-or-unix/
PS1="\[\033[0;34m\][\u@\h:\w]$\[\033[0m\]"

# Reset erase character back to ^? from ^h
[[ $- == *i* ]] && stty erase ^?

## -----------------------
## -- 2) Set up aliases --
## -----------------------

# 2.1) Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber

# 2.2) Listing, directories, and motion
if [ "$platform" == "linux" ]; then
    alias ll="ls -alrhF --color"
elif [ "$platform" == "mac" ]; then
    alias ll="ls -alrhGF"
fi
alias ..='cd ..'
alias du='du -ch'

# 2.3) Text and editor commands
alias emacs='emacs -nw'     # No X11 windows
export EDITOR='emacs -nw'
export VISUAL='emacs -nw'

# 2.4) grep options
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;31' # green for matches

if [ "$platform" == "linux" ]; then
    # LINUX 2.5) sort options
    # Ensures cross-platform sorting behavior of GNU sort.
    # http://www.gnu.org/software/coreutils/faq/coreutils-faq.html#Sort-does-not-sort-in-normal-order_0021
    unset LANG
    export LC_ALL=POSIX
    
    # set ls solarized colors
    eval `dircolors ~/.dircolors`
fi

if [ "$platform" == "mac" ]; then
    # MAC 2.5) Matlab
    alias matlab="matlab -nodesktop"
fi
