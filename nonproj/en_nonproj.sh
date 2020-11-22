#!/usr/bin/env bash

mv *.lisca lisca_rankings/en/;

for x in lisca_rankings/en/*.lisca; do
	python3 scripts/compact_lisca_scores.py $x;
done;

mv lisca_rankings/en/*.lisca_compact nonproj/;

python3 nonproj/find_non_projectivities.py -i PUDs/en-PUD/*.conllu --output;
mv non_proj_edges.tsv nonproj/en_nonproj.tsv;

cd nonproj;
for lisca_file in *.lisca_compact; do
	python3 get_np_percentile.py --lisca ${lisca_file} --non_proj en_nonproj.tsv --annotations annotations/en_annotated.tsv --output;
done;
