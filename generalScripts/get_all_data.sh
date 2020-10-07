#!/usr/bin/env bash

for x in languageSpecificScripts/*/getData.sh; do \
	echo $x; \
	sh $x; \
done;