#!/bin/sh

pull_master() {
    git checkout master
    git pull origin master
}

cd src/clojure
pull_master
ant clean jar
cd ../..

cd src/clojure-contrib
pull_master
ant clean jar
cd ../..

cd emacs-lisp/slime
pull_master
cd ../..

cd emacs-lisp/swank-clojure
pull_master
cd ../..

cd emacs-lisp/clojure-mode
pull_master
cd ../..
