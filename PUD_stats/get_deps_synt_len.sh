#!/usr/bin/env bash

if [ ! -d PUDs ]; then \
	status=18; \
	while [ $status -ne 0 ]; do \
		curl -C - --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-3424/ud-treebanks-v2.7.tgz; \
		status=$?; \
	done; \
	tar -xvf ud-treebanks-v2.7.tgz; \
	mkdir PUDs; \
	for x in ud-treebanks-v2.7/*PUD; do \
		cp $x/*.conllu PUDs/; \
	done; \
	rm -rf ud-treebanks-v2.7; \
fi;

if [ ! -d imgs ]; then \
	mkdir imgs; \
fi;

if [ ! -d imgs/Deprel-wise\ Syntactic\ Length\ Distribution ]; then \
	mkdir imgs/"Deprel-wise Syntactic Length Distribution"; \
fi;

python3 PUD_stats/get_deps_stats.py PUDs/*;