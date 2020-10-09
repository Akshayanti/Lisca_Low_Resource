#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

if [ ! -d unprocessedData/th ]; then \
  mkdir unprocessedData/th; \
fi;

cd unprocessedData/th;

if [ ! -f th.pickle ]; then \

	if [ ! -f wikiDump.xml ]; then \

	  if [ ! -f wikiDump.bz2 ]; then \
		  echo "$Red Downloading File" >&2; \
		  status=18 ; \
		  while [ $status -ne 0 ]; do \
			curl -C - --remote-name-all https://dumps.wikimedia.org/thwiki/20201001/thwiki-20201001-pages-articles-multistream.xml.bz2; \
			status=$?; \
		  done; \
		  echo "$Red Download Completed" >&2; \
		  mv thwiki-20201001-*.bz2 wikiDump.bz2; \
	  fi; \

	  echo "$Red Inflating zipped file" >&2; \
	  bzip2 -d wikiDump.bz2; \
	  mv wikiDump wikiDump.xml; \
	  echo "$Red Zip Inflation Completed"; \
	fi;

	echo "$Red Creating Pickle for First Use" >&2; \
	python3 ../../scripts/dump_pickle.py -id ./ --lang_code th; \
	echo "$Red Pickle Created" >&2; \
else
	echo "$Red Pickle Exists. No Action Necessary" >&2; \
fi;