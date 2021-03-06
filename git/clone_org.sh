#!/bin/sh

#-----------------------------------------------------------------------------
# Input Parameters
#
# access_token 
# - Your GitHub personal access token with repo scope
#
# organization
# - String value indicating the GitHub organization name
#-----------------------------------------------------------------------------

access_token=$1
organization=${2:-""} 

if [ -z "$access_token" ]
  then
    echo "access_token is required"
    exit 1
fi

curl -s https://api.github.com/orgs/"$organization"/repos?access_token="$access_token" | grep -e ssh_url | cut -d \" -f 4 | xargs -L1 git clone --recursive
