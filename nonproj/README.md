<h1>Non-Projectivity Detection in Low-Resource Scenario</h1>

<b>Hypothesis</b>: Considering that LISCA annotates the possibility of an arc, based on the local and global
features, it should be possible to identify the falsely annotated non-projective arcs in
a low-resource setting. 

<h2>Makefile targets</h2>

1. `nonproj`: Lists the non-projective arcs in a given CoNLL-U file, and based on lisca
    scores (as found in `.lisca_compact` file), calculate the percentile of the arc score
    amongst other arcs found in the file.  
    If `annotations` directory contains manual annotations 
    (cf. [Section on annotations](#annotations)), and the corresponding argument is
    used, the output also contains an additional column specifying if the arc 
    should/should not be annotated non-projectively.
2. `clean_nonproj`: Remove the generated data from `nonproj` directory. 

<h2>Annotations</h2>

The folder contains manually annotation for if the listed arcs should/should not be
non-projective in nature. The format of the data is as follows, in tsv format:

    sent_id  (head, dependent)  should_be_non_projective

In the last column, the value of `0` marks the arcs which should be non-projective, while
the value of `1` marks that the arc should be projective.

<h2>Preliminary Results</h2>

| Language Name | Number of Non-Projective Arcs | Percentile can be used as cutoff? |
|:--------------|:------------------------------|:----------------------------------| 
| `en` | 59 | :question: |