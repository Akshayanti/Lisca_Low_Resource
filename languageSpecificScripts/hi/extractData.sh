#!/usr/bin/env bash

cd unprocessedData/hi;
mkdir files;
for x in `seq 1 18`; do \
	tar -xf hi.`echo $x`.tar; \
	for y in $x/*.txt; do \
		mv $y files/; \
	done; \
	rm -rf hi.`echo $x`.tar; \
	rm -rf $x; \
done;