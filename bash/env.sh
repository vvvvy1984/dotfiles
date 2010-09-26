export PS1="\[\033[01;34m\][\$(date +%H:%M)]\[\033[01;31m\]\$(__git_ps1) \[\033[01;32m\]\h:\[\033[01;34m\]\w$\[\033[0m\] "
export EDITOR="emacs -nw"
export PATH="~/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export PYTHONPATH="."

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
