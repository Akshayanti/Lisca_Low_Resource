#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

if [ ! $1 ]; then \
	echo "$Red The first argument should be the language code" >&2; \
	echo "$Red The second (optional) argument takes the input in form of YYYYMMDD for which you want to download the dump" >&2; \
	exit; \
fi;

lang_code=$1;
dump_date=20201001;

if [ $2 ]; then \
	dump_date=$2; \
else
	day=$(date +"%d"); \
	month=$(date +"%m"); \

	if [ $day == 1 ]; then \
		month=$(expr $month - 1); \
	fi; \

	year=$(date +"%Y"); \

	if [ $month == 0 ]; then \
		year=$(expr $year - 1); \
		month=12; \
	fi; \

	if (($month<=9)); then \
		month=0`echo $month`; \
	fi; \

	dump_date=`echo $year$month`01; \
fi;

echo "$Red Processing wiki dump for `echo $lang_code` from `echo $dump_date`" >&2;

if [ ! -d unprocessedData/$lang_code ]; then \
  mkdir unprocessedData/$lang_code; \
fi;

cd unprocessedData/$lang_code;

if [ ! -f $1.pickle ]; then \

	if [ ! -f wikiDump.xml ]; then \

		if [ ! -f wikiDump.bz2 ]; then \
			echo "$Red Downloading Zip File" >&2; \
			status=18 ; \

			while [ $status -ne 0 ]; do \
				curl -C - --remote-name-all https://dumps.wikimedia.org/`echo $lang_code`wiki/`echo $dump_date`/`echo $lang_code`wiki-`echo $dump_date`-pages-articles-multistream.xml.bz2; \
				status=$?; \
			done; \
			mv `echo $lang_code`wiki-`echo $dump_date`-*.bz2 wikiDump.bz2; \
			echo "$Red Download Completed" >&2; \
		fi; \

	  echo "$Red Inflating zipped file" >&2; \
	  bzip2 -d wikiDump.bz2; \
	  mv wikiDump wikiDump.xml; \
	  echo "$Red Zip Inflation Completed"; \
	fi;

	echo "$Red Creating Pickle for First Use" >&2; \
	python3 ../../scripts/dump_pickle.py -id ./ --lang_code $lang_code; \
	echo "$Red Pickle Created" >&2; \
else
	echo "$Red Pickle Exists. No Action Necessary" >&2; \
fi;