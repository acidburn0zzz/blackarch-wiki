#!/bin/sh
# Check this before running.
# One day, this will generate a feed of some sort.

git=.
remote=https://github.com/BlackArch/blackarch-wiki
sums=sha1sums
#sleep=1m
sleep=30

sha1sum * > "$sums"

while sleep "$sleep" ; do
	if [[ ! -d "$git" ]] ; then
		git clone "$remote" "$git"
	fi

	cd "$git"

	git pull "$remote" master > /dev/null 2>&1

	if sha1sum -c sha1sums | grep -q 'build\.sh: FAILED$' ; then
		echo 'build.sh has been modified. not updating site.'
		exit 1
	fi

	./build.sh

	sha1sum * | grep -v '  sha1sums$' > "$sums"
done
