#!/usr/bin/env python3

from bs4 import BeautifulSoup as bs
from translate import Translator
import re
import tqdm
import sys


def parse_data(input_file):
    print("Reading XMLs. This might take a while depending on the language and number of files", file=sys.stderr)
    infile = open(input_file, "r", encoding="utf-8")
    data = infile.read()
    infile.close()
    return bs(data, 'xml')


def filter_content(input_files):
    strings = []
    for input_file in input_files:
        soup = parse_data(input_file)
        pages_data = soup.find_all('revision')[1:]
        for page in pages_data:
            text = [x for x in list(page.children) if x.name == "text"][0].text
            if text.strip().lstrip().rstrip() != "":
                strings.append(text)
    print("XMLs Finished Reading. Starting Filtering Through Data", file=sys.stderr)
    return strings


def standardize_quotes(line):
    tokens = line.split()
    token_out = []
    for token in tokens:
        token2 = token.replace("`", "\'")
        token2 = token2.replace("\'\'\'", "")
        token2 = token2.replace("\'\'", "\"")
        token2 = token2.replace("\"\'", "\"")
        token2 = token2.replace("\'\"", "\"")
        token_out.append(token2)
    outline = " ".join(token_out)
    outline = outline.replace("\' \"", "\"")
    outline = outline.replace("\" \'", "\"")
    outline = outline.replace("\' \'", "\'")
    return outline


def remove_links(line):
    tokens = line.split()
    tokens_list = []
    for token in tokens:
        token2 = token.replace("[[", "|||")
        token2 = token2.replace("]]", "|||")
        token2 = token2.replace("{{", "|||")
        token2 = token2.replace("}}", "|||")
        tokens_list.append(token2)
    line = " ".join(tokens_list)
    line = line.replace("||||", "|")
    split_line = line.split("|||")
    tokens_list = []
    for token in split_line:
        if token.startswith("sfn") or token == "[...]":
            continue
        elif "|" in token:
            new_token = token.split("|")[-1]
            tokens_list.append(new_token.lstrip().rstrip())
        else:
            tokens_list.append(token.lstrip().rstrip())
    out_list = []
    for token in " ".join(tokens_list).split():
        if "[" in token and "]" in token:
            split_tokens = token.split("[")
            token_split = split_tokens[0] + split_tokens[1].split("]")[0] + "".join(split_tokens[1].split("]")[1:])
            out_list.append(token_split)
        else:
            out_list.append(token)
    return " ".join(out_list).replace("  ", " ")


def process_string(article, lang_code):
    print("Removing Extraneous Metadata", file=sys.stderr)
    final_article = ""
    noParse = False
    for lines in article.split("\n"):
        line = lines.lstrip().rstrip()
        if line.startswith("|}"):
            noParse = False
            continue
        if noParse:
            continue
        if line == "":
            continue
        if line.startswith("=="):
            continue
        if line.startswith("{|"):
            noParse = True
            continue
        if line.startswith("{{"):
            continue
        if line.startswith("*") or line.startswith(":") or line.startswith("#"):
            continue
        if line.startswith("<!--"):
            continue
        if "File:" in line:
            continue
        line = standardize_quotes(line)
        line = remove_links(line)
        classify_text = ["Category:", "Classification:"]
        translator = Translator(to_lang=lang_code)
        if any([line.startswith(translator.translate(x)) for x in classify_text]):
            continue
        if line.strip("\n").lstrip().rstrip() != "":
            final_article += line.lstrip().rstrip() + "\n"
    return final_article


def process_strings(input_list, lang_code):
    out_list = []
    for given_text in input_list:
        out_list.append(process_string(given_text, lang_code))
    return out_list


def remove_refs(lines):
    before_change = len(lines.split("\n"))
    new_line, after_change = re.subn(r'<([A-Z][A-Z0-9]*)\b[^>]*>(.*?)</\1>', "", lines, flags=re.IGNORECASE)
    new_line, _ = re.subn(r'<([A-Z0-9]*)(\b.*)>(.*?)</\1>', "", new_line, flags=re.IGNORECASE | re.MULTILINE)
    new_line, _2 = re.subn(r'<([A-Z0-9]*)(\b.*)>(\n*.*\n*)</\1>', "", new_line, flags=re.IGNORECASE | re.MULTILINE)
    new_line, _3 = re.subn(r'<([A-Z0-9]*)(\b.*)>\n*(.+\n)*</\1>', "", new_line, flags=re.IGNORECASE | re.MULTILINE)
    new_line2 = len(new_line.split("\n"))
    if new_line2 * 100 / before_change <= 90.0:
        return None
    else:
        return new_line


def process_input_files(input_files, lang_code):
    final_string = ""
    data = filter_content(input_files)
    for x in tqdm.tqdm(process_strings(data, lang_code), desc="Final HouseKeeping", ncols=100):
        if remove_refs(x):
            final_string += remove_refs(x)
    return final_string
