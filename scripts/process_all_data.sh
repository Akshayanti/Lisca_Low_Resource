#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

#echo "********************************************";
#echo "********** Processing Data for hi **********";
#echo "********************************************";
#echo ""; \
#python3 scripts/hi_main.py  -id unprocessedData/hi/files > processedData/hi.txt;
#rm -rf unprocessedData/hi/files;
#echo "Dataset for 'hi' Ready in processedData Directory.";
#echo "";

for x in ar cs en "fi" id ja ko pl ru th tr zh; do \
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