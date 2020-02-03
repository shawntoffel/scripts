#!/bin/sh
set -e

version=${1:-""}

if [ -z "$version" ]; then
    echo "Looking up latest version..."
    version=$(wget -q -O - https://golang.org/VERSION?m=text)

    echo "Latest version is $version"
fi

echo "Installing version $version..."
wget -q "https://dl.google.com/go/$version.linux-amd64.tar.gz" -O - | tar -xz -C /usr/local 

echo "Exporting path..."

go_export='PATH=$PATH:/usr/local/go/bin'
profile="$HOME/.profile"
grep -qxF "$go_export" "$profile" || printf '#\nset PATH so it includes go bin\n%s' "$go_export" >> "$profile"

echo "Finished installing version $version"
