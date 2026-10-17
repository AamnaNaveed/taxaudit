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
#>            taxon      character handcoded_state extracted_state
#> 1 Cedrus deodara    growth_form            tree            tree
#> 2 Cedrus deodara leaf_length_cm         2.5-5.0         2.5-5.0
#> 3 Cedrus deodara     cone_shape           conic           conic
#> 4  Abies pindrow    growth_form            tree            tree
#> 5  Abies pindrow leaf_length_cm         3.0-6.0         3.1-5.8
#> 6  Abies pindrow   bark_texture        fissured          smooth
#>                         source_sentence    annotator       date           text
#> 1 Large evergreen tree up to 50 m tall. Aamna_Naveed 2026-06-06 Cedrus deodara
#> 2  Leaves needle-like, 2.5-5.0 cm long. Aamna_Naveed 2026-06-06 Cedrus deodara
#> 3      Cones ovoid-conic, 7-10 cm long. Aamna_Naveed 2026-06-06 Cedrus deodara
#> 4      Evergreen tree reaching 30-60 m. Aamna_Naveed 2026-06-06  Abies pindrow
#> 5       Leaves linear, 3.0-6.0 cm long. Aamna_Naveed 2026-06-06  Abies pindrow
#> 6      Bark dark gray, deeply fissured. Aamna_Naveed 2026-06-06  Abies pindrow
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
#> [1] trait         val_min       val_max       unit          span_start   
#> [6] span_end      evidence_text ontology_id  
#> <0 rows> (or 0-length row.names)
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
#> [1] 0
#> 
#> $total_a
#> [1] 0
#> 
#> $total_b
#> [1] 0
```

## 4. Held-Out Evaluation Strategy

Finally, we ensure robust generalization by splitting our dataset using
taxon-held-out cross-validation:

``` r

eval_split <- ta_split_evaluation(corpus, holdout_type = "taxon", target_holdout = "Cedrus deodara")
cat("Training set size:", nrow(eval_split$train), "\n")
#> Training set size: 12
cat("Test set size (held-out taxon):", nrow(eval_split$test), "\n")
#> Test set size (held-out taxon): 3
```
