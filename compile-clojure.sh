#!/usr/bin/env bash

cd src/clojure
ant clean jar
cd ../..

cd src/clojure-contrib
ant clean jar
cd ../..
