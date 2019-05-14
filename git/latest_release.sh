# print the latest release branches
echo `git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads/ | grep 'release-' | head -1`