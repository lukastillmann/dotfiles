#!/bin/bash


echo 'installing ringojs 3.x'
cd ~
git clone https://github.com/ringo/ringojs.git
cd ~/ringojs
./gradlew
cd ~
