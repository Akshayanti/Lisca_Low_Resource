#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

for x in cs "fi" id ko th tr; do \
	echo "********************************************"; \
	echo "*********** Getting Data for " $x " **********"; \
	echo "********************************************"; \
	sh scripts/download_complete_dump.sh $x 20201001; \
	echo ""; \
done;

echo "********************************************";
echo "*********** Getting Data for hi ************";
echo "********************************************";
sh scripts/hi.sh;
echo "";

for x in ar en ja pl ru zh; do \
	echo "********************************************"; \
	echo "*********** Getting Data for " $x " **********"; \
	echo "********************************************"; \
	sh scripts/$x.sh; \
	echo ""; \
done;