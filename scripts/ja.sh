#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

if [ ! -d unprocessedData/ja ]; then \
  mkdir unprocessedData/ja; \
fi;

cd unprocessedData/ja;

if [ ! -f ja.pickle ]; then \

	if [ ! -f wikiDump.xml ]; then \
		echo "$Red Dump1 XML File Not Found" >&2; \

		if [ ! -f wikiDump.bz2 ]; then \
			echo "$Red Downloading Dump1 XML File" >&2; \
			status=18 ; \
			while [ $status -ne 0 ]; do \
				curl -C - --remote-name-all https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream6.xml-p2807948p4224212.bz2; \
				status=$?; \
			done; \
			mv jawiki-20201001-*.bz2 wikiDump.bz2; \
			echo "$Red Dump1 Zip Download Completed" >&2; \
		else
			echo "$Red Dump1 Zip Found" >&2; \
		fi; \

		echo "$Red Inflating Dump1 Zipped file" >&2; \
		bzip2 -d wikiDump.bz2; \
		mv wikiDump wikiDump.xml; \
		echo "$Red Dump1 XML File Ready" >&2; \
	else
		echo "$Red Dump1 XML File Found" >&2; \
	fi;

	if [ ! -f wikiDump2.xml ]; then \
		echo "$Red Dump2 XML File Not Found" >&2; \

		if [ ! -f wikiDump2.bz2 ]; then \
			status=18 ; \
			while [ $status -ne 0 ]; do \
				curl -C - --remote-name-all https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream1.xml-p1p114794.bz2; \
				status=$?; \
			done; \
			mv jawiki-20201001-*.bz2 wikiDump2.bz2; \
			echo "$Red Dump2 Zip Download Completed" >&2; \
		else
			echo "$Red Dump2 Zip Found" >&2; \
		fi; \

		echo "$Red Inflating Dump2 Zipped file" >&2; \
		bzip2 -d wikiDump2.bz2; \
		mv wikiDump2 wikiDump2.xml; \
		echo "$Red Dump2 XML File Ready" >&2; \
	else
		echo "$Red Dump2 XML File Found" >&2; \
	fi;

	echo "$Red Creating Pickle for First Use" >&2; \
	python3 ../../scripts/dump_pickle.py -id ./ --lang_code ja; \
	echo "$Red Pickle Created" >&2; \
else
	echo "$Red Pickle Exists. No Action Necessary" >&2; \
fi;