#!/usr/bin/env bash

if [ ! -d ud-treebanks-v2.6.tgz ]; then \
	status=18 ; \
	while [ $status -ne 0 ]; do \
		curl -C - --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-3226/ud-treebanks-v2.6.tgz; \
		status=$?; \
	done; \
fi;