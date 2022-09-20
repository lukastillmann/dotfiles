#!/bin/bash


echo 'installing ringojs 3.x'
git clone git://github.com/ringo/ringojs.git ~/
cd ~/ringojs
./gradlew
cd ~
