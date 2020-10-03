import argparse
import os
import importlib


def set_language_data(lang_code):
    global langSpecCode
    langSpecCode = importlib.import_module("languageSpecificScripts.{x}.main".format(x=lang_code))
    importlib.invalidate_caches()


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    group0 = parser.add_mutually_exclusive_group(required=True)
    group0.add_argument("-i", "--input", nargs="+",
                        help="Input files to read data from in txt format. Multiple values possible.")
    group0.add_argument("-id", "--input_directory", type=str,
                        help="Parent directory to read txt files from. Reads .txt files recursively.")
    parser.add_argument("--lang_code", type=str, choices=['hi', 'ar', 'cs', 'de', 'en', 'fi'],
                        help="ISO Language Code for which txt files would be opened",
                        required=True)
    args = parser.parse_args()

    input_files = []
    if args.input:
        for i in args.input:
            input_files.append(i)
    elif args.input_directory:
        for root, dirs, files in os.walk(args.input_directory):
            for filename in files:
                if filename.endswith(".txt"):
                    input_files.append(os.path.join(root, filename))

    set_language_data(lang_code=args.lang_code)
    all_content = langSpecCode.process_input_files(input_files)

    print(all_content)