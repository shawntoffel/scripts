#! /bin/sh
# Removes hidden characters and uppercases

echo "$1" | sed 's/[^0-9a-zA-Z]+//g' | tr '[:lower:]' '[:upper:]'
