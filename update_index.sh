#!/bin/bash

exec > index.md

cat <<HEAD
Some of the tools in BlackArch have wiki pages on the BlackArch wiki. Below, you will find links to these pages.
For a complete list of tools, see the [tool list](http://blackarch.org/tools.html).

HEAD

printf '%s\n' *.md | grep -Ev '^(index|navigation).md' |
sed 's/\.md$//' | sort |
while read page ; do
	echo "* [$page]($page.md)"
done
