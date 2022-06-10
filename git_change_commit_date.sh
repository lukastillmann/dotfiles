#!/bin/bash

COMMIT=$1
DATE=$2

function usage() {
   echo -e "\nUsage:"
   echo -e "gitFix.sh <commit-hash> <date>"
   echo -e "\nExample:"
   echo -e "./gitFix.sh 34493f3 \$(date)"
}

function branchExists() {
   COMMIT_ID=$1
   echo $COMMIT_ID
   if [ 0 -eq $(git merge-base --is-ancestor $COMMIT_ID HEAD)  ]; then 
      return 0; 
   else 
      return 1; 
   fi
}

echo $COMMIT
echo $DATE

if [ -z "$COMMIT"  ]; then
   echo "COMMIT hash missing"
   usage
   exit 1
else
   if [ -z "$DATE"  ]; then
      echo "DATE missing"
      usage
      exit 1
   fi
fi

#git rebase $COMMIT^ -i
echo $(branchExists $COMMIT) 

echo "end"
