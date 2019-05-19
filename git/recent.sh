#!/bin/sh

# print local branches ordered by date of last commit
for k in $(git branch | perl -pe s/^..//); do
    echo "$(git show --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" "$k" -- | head -n 1)" "$k"
done | sort -r
