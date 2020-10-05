#!/usr/bin/env bash

cd unprocessedData/hi;
mkdir files;
echo "Inflating TARs. This might take a few minutes." 2>&1;
for x in `seq 1 18`; do \
	tar -xf hi.`echo $x`.tar; \
	for y in $x/*.txt; do \
		mv $y files/; \
	done; \
	rm -rf $x; \
done;
echo "TARs Inflated. Processing Files Now." 2>&1;
cd ../../;
python3 main.py --lang_code hi -id unprocessedData/hi/files > processedData/hi.txt;
rm -rf unprocessedData/hi/files;
echo "Dataset for 'hi' Ready in processedData Directory." 2>&1;