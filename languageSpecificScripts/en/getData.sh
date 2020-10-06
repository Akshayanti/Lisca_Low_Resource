#!/usr/bin/env bash

if [ ! -d unprocessedData/en ]; then \
  mkdir unprocessedData/en; \
fi;
cd unprocessedData/en;
if [ ! -f wikiDump.xml ]; then \
  echo "File Not Found." >&2; \
  if [ ! -f wikiDump.bz2 ]; then \
    echo "Downloading File" >&2; \
    status=18 ; \
    while [ $status -ne 0 ]; do \
      curl -C - --remote-name-all https://dumps.wikimedia.org/enwiki/20201001/enwiki-20201001-pages-articles-multistream1.xml-p1p41242.bz2; \
      status=$?; \
    done; \
    echo "Download Complete. Inflating zipped file" >&2; \
    mv enwiki-20201001-pages-articles-multistream1.xml-p1p41242.bz2 wikiDump.bz2; \
  fi; \
  bzip2 -d wikiDump.bz2; \
  mv wikiDump wikiDump.xml; \
  echo "Dump Complete. Starting to process the file" >&2; \
fi;