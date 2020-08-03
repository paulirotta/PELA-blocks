#!/bin/sh -ev
git reflog expire --expire-unreachable=now --all
git gc --prune=now
echo NOW: git push --all --force
