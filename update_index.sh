#!/bin/bash

exec > index.md

printf '%s\n' *.md | grep -Ev '^(index|navigation).md' |
sed 's/\.md$//' | sort |
while read page ; do
	echo "[$page]($page.md)"
done
