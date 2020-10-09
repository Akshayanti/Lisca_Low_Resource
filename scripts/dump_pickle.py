#!/usr/bin/env python3

import bz2
import _pickle as c_pickle
from bs4 import BeautifulSoup as bs
import tqdm
import argparse
import os
import logging


def parse_data(input_file):
    infile = open(input_file, "r", encoding="utf-8")
    data = infile.read()
    infile.close()
    return bs(data, 'xml')


def filter_content(in_files):
    strings = []
    logging.info("Reading Input File(s) (Step 1 of 2)")
    for input_file in tqdm.tqdm(in_files, desc="Progress", ncols=100):
        soup = parse_data(input_file)
        pages_data = soup.find_all('revision')[1:]
        for page in pages_data:
            text = [x for x in list(page.children) if x.name == "text"][0].text
            if text.strip().lstrip().rstrip() != "":
                strings.append(text)
        del soup
    return strings


def pickle_data(input_list, lang_code):
    logging.info("Dumping Pickle On Local Storage (Step 2 of 2)")
    with bz2.BZ2File("{x}.pickle".format(x=lang_code), "w") as f:
        c_pickle.dump(input_list, f)
    return


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    group0 = parser.add_mutually_exclusive_group(required=True)
    group0.add_argument("-i", "--input", nargs="+",
                        help="Input files to read data from in txt format. Multiple values possible.")
    group0.add_argument("-id", "--input_directory", type=str,
                        help="Parent directory to read txt files from. Reads .txt files recursively.")
    parser.add_argument("--lang_code", type=str, help="Language Code")
    args = parser.parse_args()

    input_files = []
    if args.input:
        for i in args.input:
            input_files.append(i)
    elif args.input_directory:
        for root, dirs, files in os.walk(args.input_directory):
            for filename in files:
                if filename.endswith(".txt") or filename.endswith(".xml"):
                    input_files.append(os.path.join(root, filename))

    logging.basicConfig(format='%(asctime)s \t %(levelname)s \t %(message)s', level=logging.INFO)
    pickle_data(filter_content(input_files), args.lang_code)
    logging.info("Closing any stranded threads")
