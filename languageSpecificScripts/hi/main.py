import sys
from tqdm import tqdm


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
    a = ""
    for x in tqdm(new_list, desc="Files Completed", ncols=100):
        text = process_input(x)
        if text:
            a += text + "\n"
    return a