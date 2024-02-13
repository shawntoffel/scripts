#!/bin/sh

#-----------------------------------------------------------------------------
# Creates an encrypted archive all repos in an organization.
#
# Required cli tools:
#   Git
#   The github cli - gh
#
# Input Parameters:
#   organization (default: "jukeizu")
#   - String value indicating the GitHub organization name
#   
#   public_key_file (default: "public_key.pem")
#   - Filepath to the public encryption key pem.
#
# To Extract a repo from a backup:
#   1. Decrypt
#     openssl smime -decrypt -binary -in date_git_bundles.tar.gz.enc -inform DER -out git_bundles.tar.gz -inkey private_key.pem
#   2. Extract bundles from the archive
#     tar -xzvf git_bundles.tar.gz
#   3. Clone a bundle
#     git clone my_repo.git.bundle
#-----------------------------------------------------------------------------

org=${1:-"jukeizu"}
public_key_file=${2:-"public_key.pem"}

# Verify git is installed.
if ! command -v git >/dev/null 2>&1; then
    echo "The git command was not found. Please install git and try again."
    exit 1
fi

# Verify the github cli tool is installed.
if ! command -v gh >/dev/null 2>&1; then
    echo "The gh command was not found. Please install the github cli and try again."
    exit 1
fi

echo "Looking up repositories for: $org"
repos=$(gh api "orgs/$org/repos" --paginate  --jq '.[].ssh_url')

mkdir -p ".tmp/clones" && mkdir -p ".tmp/git_bundles"
(
    cd .tmp/clones || exit

    echo "Cloning repositories..."
    for repo in $repos; do
        git clone --mirror "$repo"
        dir=${repo##*/}
        (
            cd "$dir" || exit
            echo "Creating $dir bundle..."
            git bundle create "../../git_bundles/$dir.bundle" --all
        )
        rm -rf "$dir"
    done
)

echo "Archiving bundles..."
name="$(date +%Y%m%d)_git_bundles"
(
    cd .tmp || exit
    tar -czvf "$name.tar.gz" git_bundles
)

echo "Encrypting archive..."
mkdir -p backups
openssl smime -encrypt -binary -aes-256-cbc -in ".tmp/$name.tar.gz" -out "backups/$name.tar.gz.enc" -outform DER "$public_key_file"
echo "Created backups/$name.tar.gz.enc"

echo "Cleaning up temporary files..."
rm -rf .tmp

echo "Done!"
