#!/usr/bin/env bash

if [ ! -d unprocessedData/ar ]; then \
  mkdir unprocessedData/ar; \
fi;

cd unprocessedData/ar;

if [ ! -f wikiDump.xml ]; then \
  if [ ! -f wikiDump.bz2 ]; then \
      echo "Downloading File" >&2; \
      status=18 ; \
      while [ $status -ne 0 ]; do \
        curl -C - --remote-name-all https://dumps.wikimedia.org/arwiki/20201001/arwiki-20201001-pages-articles-multistream4.xml-p2482316p3982315.bz2; \
        status=$?; \
      done; \
      echo "Download Complete. Inflating zipped file" >&2; \
      mv arwiki-20201001-*.bz2 wikiDump.bz2; \
  fi; \
  bzip2 -d wikiDump.bz2; \
  mv wikiDump wikiDump.xml; \
fi;

echo "Dump Complete. Starting to process the file" >&2;
