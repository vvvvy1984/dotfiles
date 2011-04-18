OS=`uname`

if [[ $OS == "Darwin" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

alias ll="ls -lh"
alias la="ls -Ah"
alias e="emacs -nw"
alias ec="emacsclient --no-wait"
alias se="sudo -H emacs -nw"
