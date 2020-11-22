#!/usr/bin/env python3

import argparse
import sys

from scipy import stats as stats

scores = dict()
percentiles = dict()
scores_arr = []


def read_lisca(input_file):
    scores_dict = dict()
    with open(input_file, "r", encoding="utf-8") as infile:
        for lines in infile:
            sent_id, token_id, token_head, arc_score = lines.strip("\n").split("\t")
            scores_dict[sent_id + "\t" + token_head + "\t" + token_id] = float(arc_score)
    return scores_dict


def read_non_proj(input_file):
    list_of_edges = []
    with open(input_file, "r", encoding="utf-8") as infile:
        for lines in infile:
            _, sent_id, pair = lines.strip("\n").split("\t")
            head, dependent = pair.strip("()").split()
            head = head.strip(",")
            list_of_edges.append(sent_id + "\t" + head + "\t" + dependent)
    return list_of_edges


def read_annotations(input_file):
    annotations = dict()
    with open(input_file, "r", encoding="utf-8") as infile:
        for lines in infile:
            sent_id, pair, annotation = lines.strip("\n").split("\t")
            head, dependent = pair.strip("()").split()
            head = head.strip(",")
            annotations[sent_id + "\t" + head + "\t" + dependent] = annotation
    return annotations


def calculate_percentile_scores(input_non_proj_tsv, input_lisca_file):
    list_of_edges = read_non_proj(input_file=input_non_proj_tsv)
    dict_of_scores = read_lisca(input_file=input_lisca_file)
    for x in list_of_edges:
        scores[x] = dict_of_scores[x]
        scores_arr.append(dict_of_scores[x])
    for x in scores:
        percentiles[x] = round(stats.percentileofscore(scores_arr, scores[x], kind="mean"), 5)


def write_outputs(output_file, annotations):
    ordered = {k: v for k, v in sorted(percentiles.items(), key=lambda item: item[1], reverse=True)}
    out_list = None
    if annotations is not None:
        out_list = [x + "\t" + str(percentiles[x]) + "\t" + annotations[x] for x in ordered]
    else:
        out_list = [x + "\t" + str(percentiles[x]) for x in ordered]
    if output_file != sys.stdout:
        with open(output_file, "w", encoding="utf-8") as outfile:
            for x in out_list:
                outfile.write(x + "\n")
    else:
        for x in out_list:
            print(x)


if __name__ == "__main__":
    parser = argparse.ArgumentParser("Program to calculate the percentile ranking of non-proj/ill-nested/non-planar"
                                     " edges, from calculated lisca scores")
    parser.add_argument("--lisca", help="Input lisca compact file to read data from", required=True)
    parser.add_argument("--non_proj", help="TSV file containing non-proj/ill-nested/non-planar edges", required=True)
    parser.add_argument("--annotations", help="TSV file containing manual annotations on projectivity of arcs")
    parser.add_argument("--output", action="store_true", help="Write outputs in a file", required=False)
    args = parser.parse_args()

    calculate_percentile_scores(args.non_proj, args.lisca)

    arg1 = args.lisca.split(".")[0] + "_percentiles.tsv" if args.output else sys.stdout
    arg2 = read_annotations(args.annotations) if args.annotations else None
    write_outputs(arg1, arg2)
