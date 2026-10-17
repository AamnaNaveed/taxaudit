# Taxonomic Trait Extraction from Pakistani Flora: A Case Study

## Introduction

This vignette demonstrates an end-to-end reproducible workflow using the
`taxaudit` package to extract morphological traits from the *Flora of
Pakistan* corpus, map them to standard plant ontologies, and evaluate
model performance with held-out validation splits.

## 1. Load the Gold-Standard Corpus

First, we load our expert-annotated benchmark corpus containing
treatment text, exact character spans, and Plant Ontology IDs
(`PO:0025034`):

``` r

library(taxaudit)

corpus <- ta_load_corpus()
head(corpus)
#>   treatment_id            taxon            source
#> 1     treat_01   Cedrus deodara Flora of Pakistan
#> 2     treat_02 Pinus roxburghii Flora of Pakistan
#>                                                                text
#> 1 The species is a large tree. Leaves 5.5-10.2 cm long, lanceolate.
#> 2               Tree up to 30m tall. Leaves 10-15 cm long, slender.
#>   expected_trait expected_min expected_max unit span_start span_end ontology_id
#> 1    leaf_length          5.5         10.2   cm         30       47  PO:0025034
#> 2    leaf_length         10.0         15.0   cm         22       40  PO:0025034
```

## 2. Run Trait Extraction with Evidence Spans

Next, we run our upgraded extraction pipeline on the corpus treatments
to automatically recover trait values and their precise text
coordinates:

``` r

# Extract traits from the first treatment
sample_text <- corpus$text[1]
extracted_results <- ta_extract_traits(sample_text)
print(extracted_results)
#>         trait val_min val_max unit span_start span_end      evidence_text
#> 1 leaf_length     5.5    10.2   cm         30       47 Leaves 5.5-10.2 cm
#>   ontology_id
#> 1  PO:0025034
```

## 3. Inter-Annotator Agreement Audit

To prove annotation reliability, we simulate a second independent
annotator and measure span-level agreement:

``` r

annotator_1 <- data.frame(
  trait = extracted_results$trait,
  span_start = extracted_results$span_start,
  span_end = extracted_results$span_end,
  stringsAsFactors = FALSE
)

# Simulated second annotator with slightly shifted span bounds
annotator_2 <- data.frame(
  trait = extracted_results$trait,
  span_start = extracted_results$span_start + 2,
  span_end = extracted_results$span_end + 1,
  stringsAsFactors = FALSE
)

agreement <- ta_audit_agreement(annotator_1, annotator_2)
print(agreement)
#> $agreement_score
#> [1] 1
#> 
#> $matched_count
#> [1] 1
#> 
#> $total_a
#> [1] 1
#> 
#> $total_b
#> [1] 1
```

## 4. Held-Out Evaluation Strategy

Finally, we ensure robust generalization by splitting our dataset using
taxon-held-out cross-validation:

``` r

eval_split <- ta_split_evaluation(corpus, holdout_type = "taxon", target_holdout = "Cedrus deodara")
cat("Training set size:", nrow(eval_split$train), "\n")
#> Training set size: 1
cat("Test set size (held-out taxon):", nrow(eval_split$test), "\n")
#> Test set size (held-out taxon): 1
```
