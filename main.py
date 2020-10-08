import argparse
import importlib
import logging


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--input", type=str, help="Input file to read pickled data from.", required=True)
    parser.add_argument("--lang_code", type=str, choices=['en', 'ja', 'ko', 'ar', 'cs', 'fi', 'id', 'th', 'tr', 'zh'],
                        help="ISO Language Code for which txt files would be opened",
                        required=True)
    args = parser.parse_args()

    pickleProcessor = importlib.import_module("scripts/process_wiki_dump")
    importlib.invalidate_caches()

    logging.basicConfig(format='%(asctime)s \t %(levelname)s \t %(message)s', level=logging.INFO)
    all_content = pickleProcessor.process_input_files(args.input, args.lang_code)
    print(all_content)