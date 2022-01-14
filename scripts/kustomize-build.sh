#!/bin/bash

COUNT=$(git log --oneline HEAD ^refs/remotes/origin/main  | wc -l)
FILES=$(git diff HEAD..HEAD~$COUNT --name-only)

for file in $FILES; do
  DIR=$(dirname $file)
  if test -f $DIR/kustomization.yaml; then
    KUST=$DIR/kustomization.yaml
    echo "found $KUST"
    kustomize build $DIR >> /dev/null
    echo $?
  fi
done
