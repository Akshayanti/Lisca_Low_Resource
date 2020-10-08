import sys
from tqdm import tqdm
import argparse
import os


def process_input(input_file):
    output_list = []
    with open(input_file, 'r', encoding='utf-8') as infile:
        for lines in infile:
            if lines.strip("\n").lstrip().rstrip() == "":
                continue
            line = lines.strip('\n')
            if '।' not in line:
                continue
            for x in line.split('।'):
                if x.lstrip().rstrip() != '':
                    output_list.append(x.lstrip().rstrip() + '।')
    text = " ".join(output_list)
    return text if text != "" else None


def process_input_files(files_list):
    new_list = sorted(files_list, key=lambda x:int(x.split("/")[-1].split(".txt")[0]))
    a = set()
    for x in tqdm(new_list, desc="Files Completed", ncols=100):
        text = process_input(x)
        if text:
            a.add(text + "\n")
    return "".join(list(a))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    group0 = parser.add_mutually_exclusive_group(required=True)
    group0.add_argument("-i", "--input", nargs="+",
                        help="Input files to read data from in txt format. Multiple values possible.")
    group0.add_argument("-id", "--input_directory", type=str,
                        help="Parent directory to read txt files from. Reads .txt files recursively.")

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

    print(process_input_files(input_files))
