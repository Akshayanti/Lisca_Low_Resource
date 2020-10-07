#!/usr/bin/env bash

if [ ! -d unprocessedData/ja ]; then \
  mkdir unprocessedData/ja; \
fi;

cd unprocessedData/ja;

if [ ! -f wikiDump.xml ]; then \
  echo "File Not Found." >&2; \
  if [ ! -f wikiDump.bz2 ]; then \
    echo "Downloading File" >&2; \
    status=18 ; \
    while [ $status -ne 0 ]; do \
      curl -C - --remote-name-all https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream6.xml-p2807948p4224212.bz2; \
      status=$?; \
    done; \
    echo "Download Complete. Inflating zipped file" >&2; \
    mv jawiki-20201001-*.bz2 wikiDump.bz2; \
  fi; \
  bzip2 -d wikiDump.bz2; \
  mv wikiDump wikiDump.xml; \
  echo "Dump Complete. Starting to process the file" >&2; \
fi;


if [ ! -f wikiDump2.xml ]; then \
  if [ ! -f wikiDump2.bz2 ]; then \
    status=18 ; \
    while [ $status -ne 0 ]; do \
      curl -C - --remote-name-all https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream1.xml-p1p114794.bz2; \
      status=$?; \
    done; \
    mv jawiki-20201001-*.bz2 wikiDump2.bz2; \
  fi; \
  bzip2 -d wikiDump2.bz2; \
  mv wikiDump2 wikiDump2.xml; \
fi;