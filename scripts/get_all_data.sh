#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

for x in ar cs en; do \
	echo "********************************************"; \
	echo "*********** Getting Data for " $x " **********"; \
	echo "********************************************"; \
	sh scripts/$x.sh; \
	echo ""; \
done;

echo "********************************************";
echo "*********** Getting Data for fi ************";
echo "********************************************";
sh scripts/fi.sh;
echo "";

echo "********************************************";
echo "*********** Getting Data for hi ************";
echo "********************************************";
sh scripts/hi.sh;
echo "";

for x in id ja ko pl ru th tr zh; do \
	echo "********************************************"; \
	echo "*********** Getting Data for " $x " **********"; \
	echo "********************************************"; \
	sh scripts/$x.sh; \
	echo ""; \
done;