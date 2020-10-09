#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

cd unprocessedData/hi;

if [ ! -d files ]; then \
	mkdir files; \

	echo "$Red Inflating zipped files" >&2; \

	for x in `seq 1 18`; do \
		tar -xf hi.`echo $x`.tar; \
		for y in $x/*.txt; do \
			mv $y files/; \
		done; \
		rm -rf $x; \
	done; \

	echo "$Red Zip Inflation Completed" >&2; \
	echo "$Red Skipped Creating Pickle" >&2; \
else
	echo "$Red Zipped Files have been extracted already. No Action Necessary" >&2; \
fi;