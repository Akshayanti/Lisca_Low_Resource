import sys
from tqdm import tqdm


def process_input(input_file, lang_code):
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


def process_input_files(files_list, lang_code):
    new_list = sorted(files_list, key=lambda x:int(x.split("/")[-1].split(".txt")[0]))
    a = set()
    for x in tqdm(new_list, desc="Files Completed", ncols=100):
        text = process_input(x, lang_code)
        if text:
            a.add(text + "\n")
    return "".join(list(a))