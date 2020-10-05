#!/usr/bin/env bash

.PHONY: preprocess

preprocess:
	pip3 install -r requirements.txt;
	if [ ! -d processedData ]; then \
		mkdir processedData; \
	fi;

hi: preprocess
	sh generalScripts/get_pud.sh;
	sh languageSpecificScripts/hi/prepareData.sh;