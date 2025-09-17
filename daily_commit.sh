#!/bin/bash

set -e

WIKI_DIR="$HOME/vimwiki"
TODAY=$(date +"%Y-%m-%d")

cd "$WIKI_DIR"
git add .
git commit -am "Auto commit of $(date +"%Y-%m-%d")"
