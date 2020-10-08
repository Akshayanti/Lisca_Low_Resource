#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

if [ ! -d unprocessedData/en ]; then \
  mkdir unprocessedData/en; \
fi;

cd unprocessedData/en;

if [ ! -f en.pickle ]; then \

	if [ ! -f wikiDump.xml ]; then \

	  if [ ! -f wikiDump.bz2 ]; then \
		echo "Downloading File" >&2; \
		status=18 ; \
		while [ $status -ne 0 ]; do \
		  curl -C - --remote-name-all https://dumps.wikimedia.org/enwiki/20201001/enwiki-20201001-pages-articles-multistream1.xml-p1p41242.bz2; \
		  status=$?; \
		done; \
		echo "$Red Download Complete. Inflating zipped file" >&2; \
		mv enwiki-20201001-*.bz2 wikiDump.bz2; \
	  fi; \

	  bzip2 -d wikiDump.bz2; \
	  mv wikiDump wikiDump.xml; \
	  echo "$Red Zip Inflation Completed" >&2; \
	fi;

	echo "$Red Creating Pickle for First Use" >&2; \
	python3 ../../scripts/dump_pickle.py -id ./ --lang_code en; \
	echo "$Red Pickle Created" >&2; \
fi;