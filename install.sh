#!/usr/bin/env bash

OS="`uname`"
INSTALL_LOCATION="`pwd`"

if [[ $OS = "Darwin" ]]; then
    BASHRC="~/.profile"
    defaults write ~/.MacOSX/environment SHARED_PROFILE_HOME $INSTALL_LOCATION
    echo "Added SHARED_PROFILE_HOME to ~/.MacOSX/environment"
else
    BASHRC="~/.bashrc"
    echo "export SHARED_PROFILE_HOME=$INSTALL_LOCATION" >> $BASHRC
    echo "Added SHARED_PROFILE_HOME to ~/.bashrc"
fi

echo "source $INSTALL_LOCATION/setup.sh" >> $BASHRC
echo "Added Shared Profile setup.sh to Bash"

echo '(load (concat (getenv "SHARED_PROFILE_HOME") "/" "setup.el"))' >> ~/.emacs
echo "Added Shared Profile setup.el to Emacs"
