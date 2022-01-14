#!/bin/bash

COUNT=$(git log --oneline HEAD ^refs/remotes/origin/main  | wc -l)
FILES=$(git diff HEAD..HEAD~$COUNT --name-only)

for file in $FILES; do
  DIR=$(dirname $file)
  if test -f $DIR/kustomization.yaml; then
    KUST=$DIR/kustomization.yaml
    echo "TESTING : $KUST"

    ERROR=$(kustomize build $DIR 2>&1 > /dev/null)

    if [ $? -eq 0 ]; then 
      echo "SUCCESS : $KUST"
    else
      echo "ERR     : $ERROR"
      echo "FAILURE : $KUST"
    fi
  fi
done
