#!/bin/bash

# Move to root
cd "$(dirname "$0")/.."

TEMPFILE=$(mktemp) && (
python3 misc/parse_navigation.py e-maxx-eng/src/navigation.md > $TEMPFILE

COMMIT_HASH="$(cd e-maxx-eng && git rev-parse --short HEAD)"
sed '/^% CONTENT GOES HERE$/r'${TEMPFILE} <(sed "s/LASTCOMMIT/${COMMIT_HASH}/" misc/template.tex)

rm $TEMPFILE
)
