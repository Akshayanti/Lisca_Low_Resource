#!/usr/bin/env bash

if [ ! -d PUDs ]; then \

	if [ ! -f ud-treebanks-v2.6.tgz ]; then \
		status=18 ; \
		while [ $status -ne 0 ]; do \
			curl -C - --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-3226/ud-treebanks-v2.6.tgz; \
			status=$?; \
		done; \
		echo "Download Complete"; \
	fi; \

	tar -xf ud-treebanks-v2.6.tgz; \
	mkdir PUDs; \

	for x in ud-treebanks-v2.6/UD_*-PUD; do \
		cp -r $x PUDs/; \
	done; \

	rm -rf ud-treebanks-v2.6*; \

	if [ ! -f ud-treebanks-v2.2.tgz ]; then \
		status=18 ; \
		while [ $status -ne 0 ]; do \
			curl -C - --remote-name-all https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-2837/ud-treebanks-v2.2.tgz; \
			status=$?; \
		done; \
		echo "Download Complete"; \
	fi; \

	tar -xf ud-treebanks-v2.2.tgz; \

	for x in English Spanish Italian; do \
		cp -rf ud-treebanks-v2.2/UD_`echo ${x}`-PUD PUDs/; \
	done; \

	rm -rf ud-treebanks-v2.2*; \

fi;

if [ -d PUDs/UD_Turkish-PUD ]; then \
	cd PUDs; \
	mv UD_Arabic-PUD ar-PUD; \
	mv UD_Chinese-PUD zh-PUD; \
	mv UD_Czech-PUD cs-PUD; \
	mv UD_English-PUD en-PUD; \
	mv UD_Finnish-PUD fi-PUD; \
	mv UD_French-PUD fr-PUD; \
	mv UD_German-PUD de-PUD; \
	mv UD_Hindi-PUD hi-PUD; \
	mv UD_Icelandic-PUD is-PUD; \
	mv UD_Indonesian-PUD id-PUD; \
	mv UD_Italian-PUD it-PUD; \
	mv UD_Japanese-PUD ja-PUD; \
	mv UD_Korean-PUD ko-PUD; \
	mv UD_Polish-PUD pl-PUD; \
	mv UD_Portuguese-PUD pt-PUD; \
	mv UD_Russian-PUD ru-PUD; \
	mv UD_Spanish-PUD es-PUD; \
	mv UD_Swedish-PUD sv-PUD; \
	mv UD_Thai-PUD th-PUD; \
	mv UD_Turkish-PUD tr-PUD; \
fi;