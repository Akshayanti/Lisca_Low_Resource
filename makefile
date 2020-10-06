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
	wc -w processedData/hi.txt;
	wc -l processedData/hi.txt;

en: preprocess
	sh languageSpecificScripts/en/getData.sh;
	python3 main.py -id unprocessedData/en --lang_code en > processedData/en.txt;
	wc -w processedData/en.txt;
	wc -l processedData/en.txt;
	echo "Dataset for 'en' Ready in processedData Directory." 2>&1;

ko: preprocess
	sh languageSpecificScripts/ko/getData.sh;
	python3 main.py -id unprocessedData/ko --lang_code ko > processedData/ko.txt;
	wc -w processedData/ko.txt;
	wc -l processedData/ko.txt;
	echo "Dataset for 'ko' Ready in processedData Directory." 2>&1;

ja: preprocess
	sh languageSpecificScripts/ja/getData.sh;
	python3 main.py -id unprocessedData/ja --lang_code ja > processedData/ja.txt;
	wc -w processedData/ja.txt;
	wc -l processedData/ja.txt;
	echo "Dataset for 'ja' Ready in processedData Directory." 2>&1;