# Load the Expert-Annotated Benchmark Corpus

Retrieves the gold-standard benchmark corpus containing plant
treatments, morphological traits, and evidence spans from package
internal files.

## Usage

``` r
ta_load_corpus()
```

## Value

A `data.frame` containing gold-standard plant treatments, traits, and
evidence spans.

## Examples

``` r
if (FALSE) { # \dontrun{
corpus <- ta_load_corpus()
head(corpus)
} # }
```
