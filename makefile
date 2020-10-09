#!/usr/bin/env bash

.PHONY: preprocess all
.SILENT: preprocess ar cs en fi hi id ja ko pl ru tr th zh all final

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

cs: preprocess
	sh scripts/download_complete_dump.sh cs;
	python3 main.py -i unprocessedData/cs/cs.pickle --lang_code cs > processedData/cs.txt;
	wc -w processedData/cs.txt;
	wc -l processedData/cs.txt;
	echo "Dataset for 'cs' Ready in processedData Directory." 2>&1;

en: preprocess
	sh scripts/en.sh;
	python3 main.py -i unprocessedData/en/en.pickle --lang_code en > processedData/en.txt;
	wc -w processedData/en.txt;
	wc -l processedData/en.txt;
	echo "Dataset for 'en' Ready in processedData Directory." 2>&1;

fi: preprocess
	sh scripts/download_complete_dump.sh fi;
	python3 main.py -i unprocessedData/fi/fi.pickle --lang_code fi > processedData/fi.txt;
	wc -w processedData/fi.txt;
	wc -l processedData/fi.txt;
	echo "Dataset for 'fi' Ready in processedData Directory." 2>&1;

hi: preprocess
	sh scripts/hi.sh;
	python3 scripts/hi_main.py  -id unprocessedData/hi/files > processedData/hi.txt;
	rm -rf unprocessedData/hi/files;
	wc -w processedData/hi.txt;
	wc -l processedData/hi.txt;
	echo "Dataset for 'hi' Ready in processedData Directory." 2>&1;

id: preprocess
	sh scripts/download_complete_dump.sh id;
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
	sh scripts/download_complete_dump.sh ko;
	python3 main.py -i unprocessedData/ko/ko.pickle --lang_code ko > processedData/ko.txt;
	wc -w processedData/ko.txt;
	wc -l processedData/ko.txt;
	echo "Dataset for 'ko' Ready in processedData Directory." 2>&1;

pl: preprocess
	sh scripts/pl.sh;
	python3 main.py -i unprocessedData/pl/pl.pickle --lang_code pl > processedData/pl.txt;
	wc -w processedData/pl.txt;
	wc -l processedData/pl.txt;
	echo "Dataset for 'pl' Ready in processedData Directory." 2>&1;

ru: preprocess
	sh scripts/ru.sh;
	python3 main.py -i unprocessedData/ru/ru.pickle --lang_code ru > processedData/ru.txt;
	wc -w processedData/ru.txt;
	wc -l processedData/ru.txt;
	echo "Dataset for 'ru' Ready in processedData Directory." 2>&1;

th: preprocess
	sh scripts/download_complete_dump.sh th;
	python3 main.py -i unprocessedData/th/th.pickle --lang_code th > processedData/th.txt;
	wc -w processedData/th.txt;
	wc -l processedData/th.txt;
	echo "Dataset for 'th' Ready in processedData Directory." 2>&1;

tr: preprocess
	sh scripts/download_complete_dump.sh tr;
	python3 main.py -i unprocessedData/tr/tr.pickle --lang_code tr > processedData/tr.txt;
	wc -w processedData/tr.txt;
	wc -l processedData/tr.txt;
	echo "Dataset for 'tr' Ready in processedData Directory." 2>&1;

zh: preprocess
	sh scripts/download_complete_dump.sh zh;
	python3 main.py -i unprocessedData/zh/zh.pickle --lang_code zh > processedData/zh.txt;
	wc -w processedData/zh.txt;
	wc -l processedData/zh.txt;
	echo "Dataset for 'zh' Ready in processedData Directory." 2>&1;

all: preprocess
	sh scripts/get_all_data.sh;
	sh scripts/process_all_data.sh;

final: preprocess
	sh scripts/get_pud.sh;
	echo  "Edit here";