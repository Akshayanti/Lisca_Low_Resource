#!/usr/bin/env bash

cd PUDs;

pwd;
for x in *-PUD; do \
	cd $x; \
		cp ../../scripts/kfold.py ./; \
		python3 kfold.py 4 *.conllu; \
		rm -f kfold.py; \
		for iter in 1 2 3 4; do \
			mkdir ${iter}; \
			mv train_`echo ${iter}` ${iter}; \
			mv test_`echo ${iter}` ${iter}; \
		done; \
	cd ..;	\
done;