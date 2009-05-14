#!/usr/bin/env bash

cd src/clojure
ant clean jar
cd ../..

cd src/clojure-contrib
ant -Dclojure.jar=../clojure/clojure.jar clean jar
cd ../..
