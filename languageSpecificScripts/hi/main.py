import sys


def process_input(input_file):
    output_list = []
    with open(input_file, 'r', encoding='utf-8') as infile:
        for lines in infile:
            line = lines.strip('\n')
            if '।' not in line:
                continue
            for x in line.split('।'):
                if x.lstrip().rstrip() != '':
                    output_list.append(x.lstrip().rstrip() + '।')
    return " ".join(output_list)


def process_input_files(files_list):
    new_list = sorted(files_list, key=lambda x:int(x.split("/")[-1].split(".txt")[0]))
    a = ""
    for x in new_list:
        a += process_input(x) + "\n"
    return a