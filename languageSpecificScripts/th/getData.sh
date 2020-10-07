#!/usr/bin/env bash

if [ ! -d unprocessedData/th ]; then \
  mkdir unprocessedData/th; \
fi;

cd unprocessedData/th;

if [ ! -f wikiDump.xml ]; then \
  if [ ! -f wikiDump.bz2 ]; then \
      echo "Downloading File" >&2; \
      status=18 ; \
      while [ $status -ne 0 ]; do \
        curl -C - --remote-name-all https://dumps.wikimedia.org/thwiki/20201001/thwiki-20201001-pages-articles-multistream.xml.bz2; \
        status=$?; \
      done; \
      echo "Download Complete. Inflating zipped file" >&2; \
      mv thwiki-20201001-*.bz2 wikiDump.bz2; \
  fi; \
  bzip2 -d wikiDump.bz2; \
  mv wikiDump wikiDump.xml; \
fi;

echo "Dump Complete. Starting to process the file" >&2;
