#!/bin/sh

# clone all repos in an organization
ACCESS_TOKEN=""
ORG=""
curl -s https://api.github.com/orgs/$ORG/repos?access_token=$ACCESS_TOKEN | grep -e ssh_url | cut -d \" -f 4 | xargs -L1 git clone --recursive
