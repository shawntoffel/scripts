#!/bin/sh

submodule="$1"

git rm "$submodule"
rm -rf ".git/modules/$submodule"
git config -f ".git/config" --remove-section "submodule.$submodule" 2> /dev/null

git commit -m "Removed $submodule submodule"
