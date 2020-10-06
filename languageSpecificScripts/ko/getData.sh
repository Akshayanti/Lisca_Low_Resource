#!/usr/bin/env bash

if [ ! -d unprocessedData/ko ]; then \
  mkdir unprocessedData/ko; \
fi;
cd unprocessedData/ko;
if [ ! -f wikiDump.xml ]; then \
  echo "File Not Found." >&2; \
  if [ ! -f wikiDump.bz2 ]; then \
    echo "Downloading File" >&2; \
    status=18 ; \
    while [ $status -ne 0 ]; do \
      curl -C - --remote-name-all https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream4.xml-p550364p983494.bz2; \
      status=$?; \
    done; \
    echo "Download Complete. Inflating zipped file" >&2; \
    mv kowiki-20201001-pages-articles-multistream4.xml-p550364p983494.bz2 wikiDump.bz2; \
  fi; \
  bzip2 -d wikiDump.bz2; \
  mv wikiDump wikiDump.xml; \
  echo "Dump Complete. Starting to process the file" >&2; \
fi;
