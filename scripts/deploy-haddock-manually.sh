#!/usr/bin/env bash

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"
cd "$cwd/.."
f=`mktemp -d`
git clone "git@github.com:relrod/mdapi.git" "$f/mdapi.git"
cabal haddock
pushd "$f/mdapi.git"
  git checkout gh-pages && git rm -rf *
popd
mv dist/doc/html/mdapi/* "$f/mdapi.git/"
pushd "$f/mdapi.git"
  git add -A
  git commit -m "Manual docs deploy."
  git push origin gh-pages
popd
rm -rf "$f"

if [ $? == 0 ]; then
  echo "*** Done: https://relrod.github.io/mdapi/"
  exit 0
else
  echo "*** ERROR!!! Fix the above and try again."
  exit 1
fi
