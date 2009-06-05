#!/usr/bin/env bash

CLOJURE_CHANGES=0
if [ "$1" = "--clj" ]; then
    RECOMPILE_CLOJURE_ON_CHANGE='true'
else
    RECOMPILE_CLOJURE_ON_CHANGE=''
fi

pull_master() {
    echo "`pwd`"
    git checkout master
    git pull origin | grep 'Already up-to-date.'
}

cd src/clojure
pull_master || CLOJURE_CHANGES=1
cd ../..

cd src/clojure-contrib
pull_master || CLOJURE_CHANGES=1
cd ../..

cd emacs-lisp/slime
pull_master
cd ../..

cd cljenv
pull_master
./update-externals.sh
cd ..

if [[ $CLOJURE_CHANGES > 0 && $RECOMPILE_CLOJURE_ON_CHANGE = 'true' ]]; then
    ./compile-clojure.sh
fi
