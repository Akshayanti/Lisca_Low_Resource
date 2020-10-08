#!/usr/bin/env bash

.PHONY: preprocess
.SILENT: preprocess ar en hi id ja ko tr th pud all

preprocess:
	python3 -m venv venv;
	source venv/bin/activate;
	pip3 install -r requirements.txt;
	if [ ! -d processedData ]; then \
		mkdir processedData; \
	fi;

ar: preprocess
	sh scripts/ar.sh;
	python3 main.py -i unprocessedData/ar/ar.pickle --lang_code ar > processedData/ar.txt;
	wc -w processedData/ar.txt;
	wc -l processedData/ar.txt;
	echo "Dataset for 'ar' Ready in processedData Directory." 2>&1;

en: preprocess
	sh scripts/en.sh;
	python3 main.py -i unprocessedData/en/en.pickle --lang_code en > processedData/en.txt;
	wc -w processedData/en.txt;
	wc -l processedData/en.txt;
	echo "Dataset for 'en' Ready in processedData Directory." 2>&1;

hi: preprocess
	sh scripts/hi.sh;
	wc -w processedData/hi.txt;
	wc -l processedData/hi.txt;

id: preprocess
	sh scripts/id.sh;
	python3 main.py -i unprocessedData/id/id.pickle --lang_code id > processedData/id.txt;
	wc -w processedData/id.txt;
	wc -l processedData/id.txt;
	echo "Dataset for 'id' Ready in processedData Directory." 2>&1;

ja: preprocess
	sh scripts/ja.sh;
	python3 main.py -i unprocessedData/ja/ja.pickle --lang_code ja > processedData/ja.txt;
	wc -w processedData/ja.txt;
	wc -l processedData/ja.txt;
	echo "Dataset for 'ja' Ready in processedData Directory." 2>&1;

ko: preprocess
	sh scripts/ko.sh;
	python3 main.py -i unprocessedData/ko/ko.pickle --lang_code ko > processedData/ko.txt;
	wc -w processedData/ko.txt;
	wc -l processedData/ko.txt;
	echo "Dataset for 'ko' Ready in processedData Directory." 2>&1;

th: preprocess
	sh scripts/th.sh;
	python3 main.py -i unprocessedData/th/th.pickle --lang_code th > processedData/th.txt;
	wc -w processedData/th.txt;
	wc -l processedData/th.txt;
	echo "Dataset for 'th' Ready in processedData Directory." 2>&1;

tr: preprocess
	sh scripts/tr.sh;
	python3 main.py -i unprocessedData/tr/tr.pickle --lang_code tr > processedData/tr.txt;
	wc -w processedData/tr.txt;
	wc -l processedData/tr.txt;
	echo "Dataset for 'tr' Ready in processedData Directory." 2>&1;

pud:
	sh scripts/get_pud.sh;

all: preprocess
	sh scripts/get_all_data.sh;
	make pud;