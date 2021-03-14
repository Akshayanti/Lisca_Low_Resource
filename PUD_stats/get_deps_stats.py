#!/usr/bin/env python3

from conllu import *
import sys
from collections import defaultdict
import matplotlib.pyplot as plt


def get_avg_sent_len(input_file):
    sent_count = 0
    token_count = 0
    with open(input_file, "r", encoding="utf-8") as infile:
        for tokenlist in parse_incr(infile):
            token_count += len(tokenlist)
            sent_count += 1
    return round(token_count/sent_count, 3)


def process_tokens(input_file):
    directed_dep_stats = dict()
    with open(input_file, "r", encoding="utf-8") as infile:
        for tokenlist in parse_incr(infile):
            sent_len = len(tokenlist)
            for token in tokenlist:
                if type(token['id']) == tuple:
                    continue
                dep_name = token['deprel']
                syntactic_length = round((token['id'] - token['head']) * 100 / sent_len, 3)
                if dep_name not in directed_dep_stats:
                    directed_dep_stats[dep_name] = [syntactic_length]
                else:
                    directed_dep_stats[dep_name].append(syntactic_length)
    faulty_keys = [x for x in directed_dep_stats.keys() if len(directed_dep_stats[x]) <= 15]
    for x in faulty_keys:
        del directed_dep_stats[x]
    return directed_dep_stats


def group_by_deprel(grouped_by_langs):
    outdict = defaultdict(dict)
    for lang_code in grouped_by_langs:
        for deprel in grouped_by_langs[lang_code]['directed_distribution_dict']:
            distribution = grouped_by_langs[lang_code]["directed_distribution_dict"][deprel]
            if deprel in outdict:
                outdict[deprel][lang_code] = distribution
            else:
                outdict[deprel] = {
                    lang_code: distribution
                }
    return outdict


def visualise(distribution_by_lang_dict, deprel_name):
    data = [distribution_by_lang_dict[z] for z in distribution_by_lang_dict.keys()]
    fig, ax = plt.subplots()
    ax.set_title("Syntactic Length of \'{}\' Across Different PUD Treebanks".format(deprel_name))
    ax.set_xlabel("Language Code")
    ax.set_ylabel("Syntactic Length Expressed As % of Sentence Length")
    plt.boxplot(data)
    plt.xticks([x for x in range(1, len(data)+1)], [x for x in distribution_by_lang_dict.keys()])
    plt.savefig("imgs/Deprel-wise Syntactic Length Distribution/{}.png".format(deprel_name))


if __name__ == "__main__":
    consolidated_dict = defaultdict(dict)
    for pud_file in sys.argv[1:]:
        lang_name = pud_file.split("/")[-1].split("_")[0]
        consolidated_dict[lang_name] = {
            "avg_sent_len": get_avg_sent_len(pud_file),
            "directed_distribution_dict": process_tokens(pud_file)
        }
    grouped_by_deprel = group_by_deprel(consolidated_dict)

    for deprel in grouped_by_deprel:
        visualise(grouped_by_deprel[deprel], deprel)