#!/usr/bin/env python3

import sys

from translate import Translator

if __name__ == "__main__":
    lang_code = sys.argv[1]
    translator = Translator(to_lang=lang_code)
    hello = translator.translate("hello")
    if hello == "":
        print("Tried translating \'hello\' into the language code provided.\n"
              "While the language code is valid, there seems to be no translation found.", file=sys.stderr)
    elif len(hello.split()) > 1:
        print("The language code you entered is invalid.", file=sys.stderr)
    else:
        print("The translation for \'hello\' in {x} is {y}\n"
              "The language is supported and is valid.".format(x=lang_code, y=hello), file=sys.stderr)