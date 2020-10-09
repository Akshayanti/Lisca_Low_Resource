import argparse
import importlib
import logging
import sys


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", type=str, help="Input file to read pickled data from.", required=True)
    parser.add_argument("--lang_code", type=str, help="ISO Language Code for which pickle file would be opened", required=True)
    parser.add_argument("--output", type=str, help="Name of Output File")
    args = parser.parse_args()

    pickleProcessor = importlib.import_module("scripts.process_wiki_dump")
    importlib.invalidate_caches()

    logging.basicConfig(format='%(asctime)s \t %(levelname)s \t %(message)s', level=logging.INFO)
    all_content = pickleProcessor.process_input_files(args.input, args.lang_code)
    if args.output:
        with open(args.output, "w", encoding="utf-8") as outfile:
            outfile.write(all_content)
    else:
        print(all_content)
