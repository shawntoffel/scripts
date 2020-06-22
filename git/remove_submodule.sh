#!/bin/sh

submodule=${1%/}

git submodule deinit -f "$submodule"
git rm "$submodule"
rm -rf ".git/modules/$submodule"
