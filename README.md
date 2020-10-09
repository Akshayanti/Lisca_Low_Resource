<h1>Reference Corpora Data for Languages</h1>

<h2>About</h2>

The objective of this repository is to clean the wikipedia dumps (XML format, containing article texts, media links, etc.) 
for most languages automatically. While the result is not perfect, it does however provide with enough for the output data
to be used in downstream applications  
as automate a pipeline that works for most wikipedia dumps,
as and when

<h2>Data Source and Statistics</h2>

| S.No. | Language Name | Tokens (in M) | Data Source | Link |
|:------|:--------------|:----------------:|:------------|:---------------|
| 1.    | `ar` : <i>al-arabiyyah</i> (Arabic) | 31.511 |  Wikipedia Dump | [Used Dump](https://dumps.wikimedia.org/arwiki/20201001/arwiki-20201001-pages-articles-multistream4.xml-p2482316p3982315.bz2) |
| 2.    | `cs` : <i>cestina</i> (Czech) | 78.004 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/cswiki/20201001/cswiki-20201001-pages-articles-multistream.xml.bz2)   |
| 3.    | `en`: English | 41.039 |  Wikipedia Dump | [Used Dump](https://dumps.wikimedia.org/enwiki/20201001/enwiki-20201001-pages-articles-multistream1.xml-p1p41242.bz2) |
| 4.    | `fi` : <i>suomen kieli</i> (Finnish) | 87.317 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/fiwiki/20201001/fiwiki-20201001-pages-articles-multistream.xml.bz2)   |
| 5.    | `hi`: Hindi | 26.072 |  Kaggle (Wikipedia) | [Kaggle Link](https://www.kaggle.com/disisbig/hindi-wikipedia-articles-172k) |
| 6.    | `id`: <i>bahasa Indonesia</i> (Indonesian) | 83.685 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/idwiki/20201001/idwiki-20201001-pages-articles-multistream.xml.bz2)   |
| 7.    | `ja`: <i>nihongo</i> (Japanese) | 31.938 | Wikipedia Dumps |  [Used Dump 1](https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream6.xml-p2807948p4224212.bz2), [Used Dump 2](https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream1.xml-p1p114794.bz2)    |
| 8.    | `ko`: <i>hangugeo</i> (Korean) | 31.510 | Wikipedia Dumps |  [Used Dump 1](https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream5.xml-p983495p1770440.bz2), [Used Dump 2](https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream4.xml-p550364p983494.bz2)    |
| 9.    | `pl` : <i>polski</i> (Polish) | 62.613 |  Wikipedia Dump | [Used Dump](https://dumps.wikimedia.org/plwiki/20201001/plwiki-20201001-pages-articles-multistream5.xml-p2047893p3462393.bz2) |
| 10.   | `ru` : <i>russkiy jizyk</i> (Russian) | 84.734 |  Wikipedia Dump | [Used Dump](https://dumps.wikimedia.org/ruwiki/20201001/ruwiki-20201001-pages-articles-multistream5.xml-p3835773p5335772.bz2) |
| 11.   | `th`: <i>phasa Thai</i> (Thai) | 13.305 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/thwiki/20201001/thwiki-20201001-pages-articles-multistream.xml.bz2)   |
| 12.   | `tr`: <i>turk dili</i> (Turkish) | 60.234 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/trwiki/20201001/trwiki-20201001-pages-articles-multistream.xml.bz2)   |
| 13.   | `zh` : <i>hanyu</i> (Chinese) | 9.903 |  Wikipedia Dump | [Used Dump1](https://dumps.wikimedia.org/zhwiki/20201001/zhwiki-20201001-pages-articles-multistream6.xml-p5596380p7096379.bz2) |

<h2>How to Use this Repo</h2>

1. [With Data as used in this repo](./#with-data-as-used-in-this-repo)
2. [With your own dump](./#with-your-own-dump)  
    1. [Pickle your dump](./#pickle-your-dump)
    2. [Using Pickle to Write Output](./#using-pickle-to-write-output)

<h3>With Data as used in this repo</h3>

1. Clone the repo in your local system.
2. Ensure you have the following tools available in your environment
    - `bzip2`
    - `wc`
    - `3.6 < python3 < 3.8`
3. For a given language code (refer table above), you can run either of the following makefile targets from the root directory:
    1. `make <lang_code>`: Download and process the data for the given language, followed by creation of dataset for the language.
    2. `make all`: Downloads and processes the data for each language, followed by creation of datasets for individual languages. 
4. The dataset for a given language would be available in `processedData/<lang_code>` as a `.txt` file.

<b>Important: Please Read:bangbang: :bangbang: :bangbang:</b>

At its peak, the directory size swells up to 50 GB. In case you have access to remote
computational cluster, you can run the `make all` therein and copy just the final datasets
being stored in `processedData` directory to your local storage.

<h3>With your own dump</h3>

<b>Note:</b> If you are using any of the Indic Languages, it is recommended to use [iNLTK](https://github.com/goru001/inltk) instead of
using this repository.

1. [Pickle your dump](./#pickle-your-dump)
2. [Using Pickle to Write Output](./#using-pickle-to-write-output)

<h4>Pickle Your Dump</h4>
  
Assuming your inflated zipped version of the dump is present in `myDir` directory, the following command will create
a pickle (to allow subsequent easier runs when you'd like to run it again) for the dump by scanning for all the `*.xml`
files in `myDir` directory, saving the pickle as `myLanguageCode.pickle`:
       
`python3 scripts/dump_pickle.py -id myDir --lang_code myLanguageCode`

<h4>Using Pickle to Write Output</h4>

After generating the pickle, the following command can be used to write the output 
in `myFile.txt`:

`python3 main.py -i myCode.pickle --lang_code myLanguageCode --output myFile.txt`

The `--output` argument is optional and when not specified, the final result is written to `stdout`


<b>Important: Please Read:bangbang: :bangbang: :bangbang:</b>

In case the language code (in above examples, `myLanguageCode`) is not valid (or not supported), the program will throw an error and exit.
To ensure that the language code you provide is valid and/or supported, you can run the following command in your terminal:
  
`python3 scripts/check_language_code.py myLanguageCode`  

Whether or not the provided language code is valid (and/or supported), you will be notified.