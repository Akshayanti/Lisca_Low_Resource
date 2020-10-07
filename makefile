#!/usr/bin/env bash

.PHONY: preprocess

preprocess:
	pip3 install -r requirements.txt;
	if [ ! -d processedData ]; then \
		mkdir processedData; \
	fi;

ar: preprocess
	sh languageSpecificScripts/ar/getData.sh;
	python3 main.py -id unprocessedData/ar --lang_code ar > processedData/ar.txt;
	wc -w processedData/ar.txt;
	wc -l processedData/ar.txt;
	echo "Dataset for 'ar' Ready in processedData Directory." 2>&1;

en: preprocess
	sh languageSpecificScripts/en/getData.sh;
	python3 main.py -id unprocessedData/en --lang_code en > processedData/en.txt;
	wc -w processedData/en.txt;
	wc -l processedData/en.txt;
	echo "Dataset for 'en' Ready in processedData Directory." 2>&1;

hi: preprocess
	sh generalScripts/get_pud.sh;
	sh languageSpecificScripts/hi/prepareData.sh;
	wc -w processedData/hi.txt;
	wc -l processedData/hi.txt;

id: preprocess
	sh languageSpecificScripts/id/getData.sh;
	python3 main.py -id unprocessedData/id --lang_code id > processedData/id.txt;
	wc -w processedData/id.txt;
	wc -l processedData/id.txt;
	echo "Dataset for 'id' Ready in processedData Directory." 2>&1;

ja: preprocess
	sh languageSpecificScripts/ja/getData.sh;
	python3 main.py -id unprocessedData/ja --lang_code ja > processedData/ja.txt;
	wc -w processedData/ja.txt;
	wc -l processedData/ja.txt;
	echo "Dataset for 'ja' Ready in processedData Directory." 2>&1;

ko: preprocess
	sh languageSpecificScripts/ko/getData.sh;
	python3 main.py -id unprocessedData/ko --lang_code ko > processedData/ko.txt;
	wc -w processedData/ko.txt;
	wc -l processedData/ko.txt;
	echo "Dataset for 'ko' Ready in processedData Directory." 2>&1;

tr: preprocess
	sh languageSpecificScripts/tr/getData.sh;
	python3 main.py -id unprocessedData/tr --lang_code tr > processedData/tr.txt;
	wc -w processedData/tr.txt;
	wc -l processedData/tr.txt;
	echo "Dataset for 'tr' Ready in processedData Directory." 2>&1;

th: preprocess
	sh languageSpecificScripts/th/getData.sh;
	python3 main.py -id unprocessedData/th --lang_code th > processedData/th.txt;
	wc -w processedData/th.txt;
	wc -l processedData/th.txt;
	echo "Dataset for 'th' Ready in processedData Directory." 2>&1;