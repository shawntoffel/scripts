#!/bin/sh

filename=$(basename "$1")
kubectl create secret generic "$filename" --from-file="$filename=$1" --from-literal="${filename}_password=$2"
