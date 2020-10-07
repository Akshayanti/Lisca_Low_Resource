<h1>Reference Corpora Data for Languages</h1>

<h2>Data Source</h2>

| S.No. | Language Name | Language Code | Data Source | Link |
|:------|:--------------|:-------------:|:------------|:---------------|
| 1.    | English :white_check_mark: | en            |  Wikipedia Dumps | [Dump](https://dumps.wikimedia.org/enwiki/20201001/enwiki-20201001-pages-articles-multistream1.xml-p1p41242.bz2) |
| 2.    | Hindi :white_check_mark: | hi            |  Kaggle (Wikipedia) | [Link](https://www.kaggle.com/disisbig/hindi-wikipedia-articles-172k) |
| 3.    | Japanese :white_check_mark: | ja    | Wikipedia Dumps |  [Dump1](https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream6.xml-p2807948p4224212.bz2), [Dump2](https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream1.xml-p1p114794.bz2)    |
| 4.    | Korean :white_check_mark: | ko    | Wikipedia Dumps |  [Dump1](https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream5.xml-p983495p1770440.bz2), [Dump2](https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream4.xml-p550364p983494.bz2)    |

Languages Coming Soon:
- Arabic (ar)
- Zhou Chinese (zh)
- Czech (cs)
- Finnish (fi)
- Indonesian (id)
- Thai (th)
- Turkish (tr)

<h2>How to Use the Repo</h2>

1. Clone the repo in your local system.
2. Ensure you have the following tools available in your environment
    - `bzip2`
    - `wc`
    - `python3`
3. For a given language code (refer table above), run `make <lang_code>` from the root directory.
4. The final results will be available in `processedData/<lang_code>` as a `.txt` file. 