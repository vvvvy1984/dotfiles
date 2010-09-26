#!/usr/bin/env bash

OS="`uname`"
INSTALL_LOCATION="`pwd`"

mv ~/.bashrc ~/.bashrc.local
ln -sf $INSTALL_LOCATION/bash/bashrc ~/.bashrc
echo "Symlinked ~/.bashrc to bash/bashrc"

if [ -d ~/.emacs.d ]; then
    mv ~/.emacs.d ~/.emacs.d.old
    echo "Moved old .emacs.d to .emacs.d.old"
fi

ln -sf $INSTALL_LOCATION/emacs-lisp ~/.emacs.d
echo "Symlinked ~/.emacs.d to emacs-lisp"

mkdir -p $HOME/.xmonad
ln -sf "$INSTALL_LOCATION/xmonad.hs" /home/cosmin/.xmonad/
echo "Installed xmonad.hs to ~/.xmonad/xmonad.hs"

ln -sf $INSTALL_LOCATION/xmobarrc ~/.xmobarrc
