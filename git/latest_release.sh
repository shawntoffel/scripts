#!/bin/sh
# print the latest release branches
git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ | grep 'release-' | head -1
