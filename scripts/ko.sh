#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

if [ ! -d unprocessedData/ko ]; then \
  mkdir unprocessedData/ko; \
fi;

cd unprocessedData/ko;

if [ ! -f ko.pickle ]; then \

	if [ ! -f wikiDump.xml ]; then \

	  if [ ! -f wikiDump.bz2 ]; then \
		  echo "$Red Downloading File(s)" >&2; \
		  status=18 ; \
		  while [ $status -ne 0 ]; do \
			curl -C - --remote-name-all https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream5.xml-p983495p1770440.bz2; \
			status=$?; \
		  done; \
		  mv kowiki-20201001-*.bz2 wikiDump.bz2; \
	  fi; \

	  bzip2 -d wikiDump.bz2; \
	  mv wikiDump wikiDump.xml; \
	fi;

	if [ ! -f wikiDump2.xml ]; then \

	  if [ ! -f wikiDump2.bz2 ]; then \
		status=18 ; \
		while [ $status -ne 0 ]; do \
		  curl -C - --remote-name-all https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream4.xml-p550364p983494.bz2; \
		  status=$?; \
		done; \
		mv kowiki-20201001-*.bz2 wikiDump2.bz2; \
	  fi; \

	  bzip2 -d wikiDump2.bz2; \
	  mv wikiDump2 wikiDump2.xml; \
	fi;

	echo "$Red Creating Pickle for First Use" >&2; \
	python3 ../../scripts/dump_pickle.py -id ./ --lang_code ko; \
	echo "$Red Pickle Created" >&2; \
fi;