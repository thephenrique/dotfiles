#!/bin/bash

#
# git-next
#
# From the master/main branch, go to the first commit in the history and navigate
# step by step through the commits of a Git repository.
#
# When we want to review the progress of a project — commit by commit — Git doesn't offer
# a native command to "go to the next commit". `git-next` solves this.
#

main_branch=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||')
current_branch=$(git symbolic-ref --short HEAD 2>/dev/null)

readarray -t commits < <(git rev-list $main_branch --reverse)
current_commit=$(git rev-parse HEAD)

if [[ "$current_branch" == "main" || "$current_branch" == "master" ]]; then
  git checkout "${commits[0]}"
  exit
fi

for i in "${!commits[@]}"; do
  if [[ "${commits[$i]}" == "${current_commit}" ]]; then
    git checkout "${commits[$((i + 1))]}"
    break
  fi
done
