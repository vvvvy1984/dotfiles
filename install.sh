#!/usr/bin/env bash

OS="`uname`"
INSTALL_LOCATION="`pwd`"

if [[ `readlink ~/.bashrc` == $INSTALL_LOCATION/bash/bashrc ]]; then
    echo "bashrc already configured"
else
    mv ~/.bashrc ~/.bashrc.local
    ln -sf $INSTALL_LOCATION/bash/bashrc ~/.bashrc
    echo "Symlinked ~/.bashrc to bash/bashrc"
fi

if [[ `readlink ~/.emacs.d` == $INSTALL_LOCATION/emacs-lisp ]]; then
    echo "Emacs already configured"
else
    if [ -d ~/.emacs.d ]; then
        mv ~/.emacs.d ~/.emacs.d.old
        echo "Moved old .emacs.d to .emacs.d.old"
    fi

    ln -sf $INSTALL_LOCATION/emacs-lisp ~/.emacs.d
    echo "Symlinked ~/.emacs.d to emacs-lisp"
fi

echo ""
echo "** To configure XMonad run **"
echo ln -sf "$INSTALL_LOCATION/xmonad.hs" $HOME/.xmonad/
echo ln -sf $INSTALL_LOCATION/xmobarrc ~/.xmobarrc
echo ""

if [[ `readlink ~/.gitconfig` == $INSTALL_LOCATION/git/config ]]; then
    echo "Git already configured"
else
    mv ~/.gitconfig ~/.gitconfig.local

    ln -sf $INSTALL_LOCATION/git/config ~/.gitconfig
    ln -sf $INSTALL_LOCATION/git/ignore ~/.gitignore
fi
