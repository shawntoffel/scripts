#!/bin/sh

submodule=${1%/}

git rm "$submodule"
rm -rf ".git/modules/$submodule"
git config -f ".git/config" --remove-section "submodule.$submodule"
