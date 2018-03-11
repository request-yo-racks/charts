#!/bin/bash
set -exuo pipefail

# Go back to the root of the project and checkout gh-pages.
GROOT=$(git rev-parse --show-toplevel)
cd "${GROOT}"
git checkout -b gh-pages origin/gh-pages || git checkout gh-pages

# Reindex
helm repo index --url https://request-yo-racks.github.io/charts .

# Add the new packages.
git add .
FILES=$(git status -s)
git commit -am "Publish charts" -m "${FILES}"

# Push the branch.
git push origin gh-pages

# Return to the master.
git checkout master
