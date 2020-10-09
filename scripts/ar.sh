#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

if [ ! -d unprocessedData/ar ]; then \
  mkdir unprocessedData/ar; \
fi;

cd unprocessedData/ar;

if [ ! -f ar.pickle ]; then \

	if [ ! -f wikiDump.xml ]; then \

	  if [ ! -f wikiDump.bz2 ]; then \
		  echo "$Red Downloading File" >&2; \
		  status=18 ; \
		  while [ $status -ne 0 ]; do \
			curl -C - --remote-name-all https://dumps.wikimedia.org/arwiki/20201001/arwiki-20201001-pages-articles-multistream4.xml-p2482316p3982315.bz2; \
			status=$?; \
		  done; \
		  echo "$Red Download Completed" >&2; \
		  mv arwiki-20201001-*.bz2 wikiDump.bz2; \
	  fi; \

	  echo "$Red Inflating zipped file" >&2; \
	  bzip2 -d wikiDump.bz2; \
	  mv wikiDump wikiDump.xml; \
	  echo "$Red Zip Inflation Completed"; \
	fi;

	echo "$Red Creating Pickle for First Use" >&2; \
	python3 ../../scripts/dump_pickle.py -id ./ --lang_code ar; \
	echo "$Red Pickle Created" >&2; \
else
	echo "$Red Pickle Exists. No Action Necessary" >&2; \
fi;