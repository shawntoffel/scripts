#!/bin/bash

([ -n "$1" ] && kubectl config use-context "$1") || kubectl config get-contexts
