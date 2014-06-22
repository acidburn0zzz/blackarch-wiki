#!/bin/sh
# Do not run this directly from the git repo.
# Copy and check it first.

git=.
remote=https://github.com/BlackArch/blackarch-wiki

if [[ ! -d "$git" ]] ; then
	git clone "$remote" "$git"
fi

cd "$git"

git pull "$remote" master

if sha1sum -c sha1sums | grep -q 'build\.sh: FAILED$' ; then
	echo 'build.sh has been modified. not updating site.'
	exit 1
fi

sha1sum * > sha1sums
