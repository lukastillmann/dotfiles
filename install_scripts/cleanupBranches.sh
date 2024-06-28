#!/bin/bash

# Fetch the latest changes from the remote repository
git fetch --all --prune

# Get the current date
current_date=$(date +%s)

# Set the cutoff period to 3 months (90 days)
cutoff_days=60
cutoff_seconds=$((cutoff_days * 24 * 60 * 60))

# Get the list of branches with their last commit dates
branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short) %(committerdate:unix)')

# Iterate through each branch and check if it should be deleted
while read -r branch commit_date; do
  # Calculate the age of the branch
  branch_age=$((current_date - commit_date))
  
  # Check if the branch is older than the cutoff period
  if [ $branch_age -gt $cutoff_seconds ]; then
    # Make sure to not delete the current branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$branch" != "$current_branch" ]; then
      echo "Deleting branch: $branch"
      git branch -D "$branch"
    else
      echo "Skipping current branch: $branch"
    fi
  fi
done <<< "$branches"
