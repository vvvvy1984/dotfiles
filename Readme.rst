Bash
====

Add this to your .bashrc

.. sourcecode:: bash

    export SHARED_PROFILE_HOME=/path/to/shared-profile
    source $SHARED_PROFILE_HOME/bash-env
    source $SHARED_PROFILE_HOME/bash-aliases
    source $SHARED_PROFILE_HOME/bash-functions

Emacs
=====

Add this to your .emacs

.. sourcecode:: common-lisp

    (load (concat (getenv "SHARED_PROFILE_HOME") "/" "setup.el"))

