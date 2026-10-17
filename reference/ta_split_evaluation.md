# Split Corpus Data for Held-Out Evaluation

Split Corpus Data for Held-Out Evaluation

## Usage

``` r
ta_split_evaluation(
  corpus_df,
  holdout_type = c("taxon", "source"),
  target_holdout
)
```

## Arguments

- corpus_df:

  Data frame containing the annotated corpus (must include columns like
  taxon and source).

- holdout_type:

  Character string: either "taxon" or "source".

- target_holdout:

  Value of the taxon or source to hold out (e.g., "Cedrus deodara" or
  "Flora of Pakistan Vol 2").

## Value

A list with training/evaluation data splits.
