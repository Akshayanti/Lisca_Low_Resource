#!/usr/bin/env python3

import argparse

import conllu

ID, FORM, LEMMA, UPOS, XPOS, FEATS, HEAD, DEPREL, DEPS, MISC = range(10)


def read_files(filename):
    return_dict = dict()
    with open(filename, "r", encoding="utf-8") as infile:
        sent_id = "xx"
        sentence = ""
        for lines in infile:
            if lines == "\n":
                return_dict[sent_id] = sentence
                sent_id = "xx"
                sentence = ""
            elif lines.startswith("#"):
                if lines.startswith("# sent_id"):
                    sent_id = lines.strip("\n").split(" = ")[1]
                else:
                    pass
            else:
                token_data = lines.strip("\n").split("\t")
                if "-" in token_data[ID] or token_data[UPOS] in ["PUNCT", "SYM"]:
                    continue
                else:
                    sentence += token_data[FORM].lower()
        return_dict[sent_id] = sentence
    return return_dict


def write_cleaned_version(output_filename, input_parsed_file, whitelist_sent_id):
    outfile = open(output_filename, "w+", encoding="utf-8")
    with open(input_parsed_file, "r", encoding="utf-8") as infile:
        for sentence in conllu.parse_incr(infile):
            if sentence.metadata["sent_id"] in whitelist_sent_id:
                outfile.writelines(sentence.serialize())
    outfile.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--pud", type=str,
                        help="Input PUD file to read data from, in CoNLL-U format.", required=True)
    parser.add_argument("--parsed", type=str,
                        help="Input CoNLL-U file to clean.", required=True)
    parser.add_argument("--output", type=str,
                        help="Output file to write cleaned data in.", required=False)
    args = parser.parse_args()

    pud_content = read_files(args.pud)
    parsed_content = read_files(args.parsed)
    writable_ids = [x for x in parsed_content.keys() if parsed_content[x] not in pud_content.values()]

    outname = args.output if args.output else (args.parsed.rstrip(".conllu") + "_cleaned.conllu")

    write_cleaned_version(outname, args.parsed, writable_ids)
