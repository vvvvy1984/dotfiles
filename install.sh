#!/usr/bin/env bash

OS="`uname`"
INSTALL_LOCATION="`pwd`"

if [[ $OS = "Darwin" ]]; then
    BASHRC="~/.profile"
    #defaults write ~/.MacOSX/environment SHARED_PROFILE_HOME $INSTALL_LOCATION
else
    BASHRC="~/.bashrc"
fi

echo "source $INSTALL_LOCATION/bash/init.sh" >> $BASHRC
echo "Added dotfiles init.sh to Bash"

ln -sf $INSTALL_LOCATION/emacs-lisp ~/.emacs.d
echo "Symlinked ~/.emacs.d to emacs-lisp"
