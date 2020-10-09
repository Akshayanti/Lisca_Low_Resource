#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

for x in ar cs en; do \
	echo "********************************************"; \
	echo "********** Processing Data for " $x " ********"; \
	echo "********************************************"; \
	echo ""; \
	python3 main.py -i unprocessedData/$x/$x.pickle --lang_code $x > processedData/$x.txt; \
	echo "Dataset for '" $x "' Ready in processedData Directory." 2>&1; \
	echo ""; \
done;

echo "********************************************";
echo "********** Processing Data for fi **********";
echo "********************************************";
echo ""; \
python3 main.py -i unprocessedData/fi/fi.pickle --lang_code fi > processedData/fi.txt;
echo "Dataset for 'fi' Ready in processedData Directory." 2>&1;
echo "";

echo "********************************************";
echo "********** Processing Data for hi **********";
echo "********************************************";
echo ""; \
python3 scripts/hi_main.py  -id unprocessedData/hi/files > processedData/hi.txt;
rm -rf unprocessedData/hi/files;
echo "Dataset for 'hi' Ready in processedData Directory.";
echo "";

for x in id ja ko pl ru th tr zh; do \
	echo "********************************************"; \
	echo "********** Processing Data for " $x " ********"; \
	echo "********************************************"; \
	echo ""; \
	python3 main.py -i unprocessedData/$x/$x.pickle --lang_code $x > processedData/$x.txt; \
	echo "Dataset for '" $x "' Ready in processedData Directory." 2>&1; \
	echo ""; \
done;

echo "";
echo "";
echo "";
echo "";
echo "Datasets for all the languages have been created, and can be found in processedData Directory";