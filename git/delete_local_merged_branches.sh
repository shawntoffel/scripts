 # delete all local branches that have been merged. Also prunes stale local remote refs.
echo "deleting local merged branches..."
for b in `git branch --merged | grep -v \*`; do
    git branch -d $b
done

echo "pruning stale remote refs"
git remote prune origin
