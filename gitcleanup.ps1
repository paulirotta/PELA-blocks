#!/bin/sh -ev
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch *.stl" --prune-empty --tag-name-filter cat -- --all
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch *.png" --prune-empty --tag-name-filter cat -- --all
git reflog expire --expire-unreachable=now --all
git gc --prune=now
echo NOW MANUALLY TYPE THE FOLLOWING TO SAVE SPACE ON GITHUB ALSO:
echo   git push --all --force
