#!/bin/bash
set -euo pipefail

# Save the current branch.
PREVIOUS_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Return to the previous branch.
function previous_branch {
  git checkout "${PREVIOUS_BRANCH}"
}

# Go back to the root of the project
GROOT=$(git rev-parse --show-toplevel)
cd "${GROOT}"

# Checkout gh-pages.
git checkout -b gh-pages origin/gh-pages 2>/dev/null || git checkout gh-pages

# Check for new packages.
if [ -d dist ]; then
  echo "Nothing to publish."
  previous_branch
  exit 0
fi

NEW_PACKAGES=0
for f in $(ls dist/*); do
  if [ ! -f "basename ${f}" ]; then
    cp "${f}" .
    NEW_PACKAGES=1
  fi
done
rm -fr ./dist

if [ "${NEW_PACKAGES}" -eq 0 ]; then
  echo "Nothing new to publish."
  previous_branch
  exit 0
fi

# Reindex
helm repo index --url https://request-yo-racks.github.io/charts .

# Add the new packages.
git add .
FILES=$(git status -s)
git commit -am "Publish charts" -m "${FILES}"

# Push the branch.
git push origin gh-pages

# Return to the previous branch.
previous_branch
