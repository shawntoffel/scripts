if [ -n "$1" ]; then
    branch="$1"
else
    branch=`git-latestrelease`
fi

git fetch origin "$branch:$branch"