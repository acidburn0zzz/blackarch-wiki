#!/bin/sh
# Audit this and build.sh before running.
# One day, this will generate a feed of some sort.

git=.
remote=https://github.com/BlackArch/blackarch-wiki
sums=sha1sums
sleep=1m

sha1sum * > "$sums"

while sleep "$sleep" ; do
	if [[ ! -d "$git" ]] ; then
		git clone "$remote" "$git"
	fi

	cd "$git"

	git pull "$remote" master > /dev/null 2>&1

	if sha1sum -c sha1sums | grep -q 'build\.sh: FAILED$' ; then
		echo 'build.sh has been modified. not updating site.'
	else
		./build.sh
		sha1sum * | grep -v '  sha1sums$' > "$sums"
	fi
done
