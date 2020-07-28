#! /bin/sh

ticket=$(git branch --show-current | grep -oP '^(\w+-\d+)')
message="$ticket $1"

if [ "$2" = "--dry-run" ]; then
    echo "$message"
    exit
fi

git commit -m "$message"
