#!/bin/sh
set -e

[ "${1##*.}" = "pfx" ] || (echo "file input must have pfx extension" && exit 1)

base=${1%.pfx}
openssl pkcs12 -in "$base.pfx" -out "$base.pem" -nodes

echo "created $base.pem"