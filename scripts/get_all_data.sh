#!/usr/bin/env bash

Red=$'\e[1;31m'
echo "$Red " >&2;

for x in en ar id ja ko th tr; do \
	echo "********************************************"; \
	echo "*********** Getting Data for " $x " **********"; \
	echo "********************************************"; \
	sh scripts/$x.sh; \
	echo ""; \
done;

echo "********************************************";
echo "************ Getting PUD Data **************";
echo "********************************************";

sh scripts/get_pud.sh;