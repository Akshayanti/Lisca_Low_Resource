#!/usr/bin/env python3

import sys

scores = dict()


def read_lisca_file(input_file=sys.argv[1]):
    with open(input_file, "r", encoding="utf-8") as infile:
        for lines in infile:
            line = lines.strip("\n")
            sent_id, _, _2, token_id, form, lemma, upos, xpos, feats, head, deprel, score = line.split("\t")
            scores[sent_id + "\t" + token_id + "\t" + head] = score


def write_output(output_file=sys.argv[1]):
    with open(output_file + "_compact", "w", encoding="utf-8") as outfile:
        for x in scores:
            out_string = x + "\t" + scores[x] + "\n"
            outfile.write(out_string)
    return


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Enter the lisca file as an argument")
        exit(1)
    read_lisca_file()
    write_output()
