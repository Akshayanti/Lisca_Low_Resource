<h1>Reference Corpora Data for Languages</h1>

<h2>Data Source</h2>

<h3>Languages Ready to be Used</h3>

| S.No. | Language Name | Tokens (in M) | Data Source | Link |
|:------|:--------------|:----------------:|:------------|:---------------|
| 1.    | `ar` : <i>al-arabiyyah</i> (Arabic) | 31.511 |  Wikipedia Dump | [Used Dump](https://dumps.wikimedia.org/arwiki/20201001/arwiki-20201001-pages-articles-multistream4.xml-p2482316p3982315.bz2) |
| 2.    | `en`: English | 41.039 |  Wikipedia Dump | [Used Dump](https://dumps.wikimedia.org/enwiki/20201001/enwiki-20201001-pages-articles-multistream1.xml-p1p41242.bz2) |
| 3.    | `hi`: Hindi | 26.072 |  Kaggle (Wikipedia) | [Kaggle Link](https://www.kaggle.com/disisbig/hindi-wikipedia-articles-172k) |
| 4.    | `id`: <i>bahasa Indonesia</i> (Indonesian) | 83.685 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/idwiki/20201001/idwiki-20201001-pages-articles-multistream.xml.bz2)   |
| 5.    | `ja`: <i>nihongo</i> (Japanese) | 31.938 | Wikipedia Dumps |  [Used Dump 1](https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream6.xml-p2807948p4224212.bz2), [Used Dump 2](https://dumps.wikimedia.org/jawiki/20201001/jawiki-20201001-pages-articles-multistream1.xml-p1p114794.bz2)    |
| 6.    | `ko`: <i>hangugeo</i> (Korean) | 31.510 | Wikipedia Dumps |  [Used Dump 1](https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream5.xml-p983495p1770440.bz2), [Used Dump 2](https://dumps.wikimedia.org/kowiki/20201001/kowiki-20201001-pages-articles-multistream4.xml-p550364p983494.bz2)    |
| 7.    | `th`: <i>phasa Thai</i> (Thai) | 13.305 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/thwiki/20201001/thwiki-20201001-pages-articles-multistream.xml.bz2)   |
| 8.    | `tr`: <i>turk dili</i> (Turkish) | 60.234 | Wikipedia Dump |  [Complete Dump](https://dumps.wikimedia.org/trwiki/20201001/trwiki-20201001-pages-articles-multistream.xml.bz2)   |

<h3>Languages To Be Added</h3>

- `cs` : <i>cestina</i> (Czech)
- `fi` : <i>suomen kieli</i> (Finnish)
- `pl` : <i>polski</i> (Polish)
- `ru` : <i>russkiy jizyk</i> (Russian)
- `zh` : <i>hanyu</i> (Chinese)

<h2>How to Use the Repo</h2>

1. Clone the repo in your local system.
2. Ensure you have the following tools available in your environment
    - `bzip2`
    - `wc`
    - `3.6 < python3 < 3.9`
3. For a given language code (refer table above), run `make <lang_code>` from the root directory.
4. The final results will be available in `processedData/<lang_code>` as a `.txt` file. 