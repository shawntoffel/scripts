 # delete all local branches that have been merged. Also prunes stale local remote refs.
for b in `git branch --merged | grep -v \*`; do
    git branch -d $b
done

git remote prune origin