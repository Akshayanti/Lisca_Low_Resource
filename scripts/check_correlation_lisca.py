#!/usr/bin/env python3

import argparse

import pandas as pd

# define constant for calculating ranks as per the order in which arcs occur
ARCS_IN_ORDER = 1
# define constant for calculating ranks as per the scores, multiple items with same score with equal ranks
ARCS_NO_ORDER = 0


def read_data(input_file, calculation_mode, score_limit=1):
    file_ranks = dict()
    prev_score = 12
    current_rank = 0
    with open(input_file, "r", encoding="utf-8") as infile:
        for lines in infile.readlines():
            sentID, tokenID, _, _2, form, lemma, upos, xpos, feats, head, deprel, score = lines.strip("\n").split("\t")
            score = float(score.split("e")[0]) * pow(10, int(score.split("e")[1])) if score != "0.0" else 0
            token_identifier = sentID + "#" + tokenID
            if calculation_mode == ARCS_IN_ORDER:
                current_rank += 1
                if score <= score_limit:
                    file_ranks[token_identifier] = current_rank
            else:
                if score <= score_limit:
                    current_rank = (current_rank + 1) if score < prev_score else current_rank
                    file_ranks[token_identifier] = current_rank
                    prev_score = score
    return file_ranks


def compute_correlation(dict1, dict2, correlation_type):
    combined_dict = dict()
    for x in set([z for z in dict1.keys() if z in dict2.keys()]):
        combined_dict[x] = [dict1[x], dict2[x]]
    df = pd.DataFrame(data=combined_dict).transpose()
    print(df.corr(method=correlation_type))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--input1", type=str, help="Input .lisca file to read data from", required=True)
    parser.add_argument("--input2", type=str, help="Input .lisca file to compare against", required=True)
    group0 = parser.add_mutually_exclusive_group(required=True)
    group0.add_argument("--calculate_ranks_by_order", action='store_true',
                        help="Calculate arc rank by the order of its appearance.")
    group0.add_argument("--calculate_ranks_by_score", action='store_false',
                        help="Calculate arc rank by their scores. Arcs with same score have same rank.")
    parser.add_argument("--filter_scores", default=1.0, type=float, required=False,
                        help="Calculate ranks of arcs with lisca scores of less than or equal to specified value")
    parser.add_argument("--correlation_type", default="spearman", choices=["spearman", "pearson", "kendall"], type=str,
                        help="Type of correlation to be calculated", required=False)
    args = parser.parse_args()

    calculation_mode = ARCS_IN_ORDER if args.calculate_ranks_by_order else ARCS_NO_ORDER
    d1 = read_data(input_file=args.input1, calculation_mode=calculation_mode, score_limit=args.filter_scores)
    d2 = read_data(input_file=args.input2, calculation_mode=calculation_mode, score_limit=args.filter_scores)
    compute_correlation(d1, d2, correlation_type=args.correlation_type)
