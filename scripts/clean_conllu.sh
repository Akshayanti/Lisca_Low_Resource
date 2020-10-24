#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

if [ ! $1 ]; then \
	echo "$Red The first argument should be the directory name containing the UDPIPE parsed CoNLL-U files" >&2; \
	echo "$Red The second argument should be the language code" >&2; \
	exit; \
fi;

if [ ! $2 ]; then \
	echo "$Red The first argument should be the directory name containing the UDPIPE parsed CoNLL-U files" >&2; \
	echo "$Red The second argument should be the language code" >&2; \
	exit; \
fi;

processedData=$1;
langCode=$2;

if [ ! -d filteredData ]; then \
  mkdir filteredData; \
fi;

for x in PUDs/`echo ${langCode}`-PUD/*.conllu; do \
	cat $x >> temp-pud.conllu; \
done;

for x in `echo ${processedData}`/`echo ${langCode}`*; do \
	python3 scripts/clean_conllu.py --pud temp-pud.conllu --parsed $x --output filteredData/`echo ${langCode}`.conllu; \
done;

rm -f temp-pud.conllu;

echo "Filtered data saved in filteredData/"${langCode}".conllu" >&2;