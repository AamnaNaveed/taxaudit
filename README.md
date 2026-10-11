# taxaudit: Taxonomic Diagnosability Auditing in R

> **Status:** Working Prototype (Experimental)

`taxaudit` is an R package designed to move taxonomic data auditing beyond naive text length scoring toward rigorous, ontology-based **Pairwise Diagnosability Index (DI)** calculations and contrast matrix generation for taxonomists.

---

## Core Methodology

Traditional automated flora metrics often rely on descriptive word counts or character lengths. However, a species can have a lengthy description yet remain completely indistinguishable from its sibling species if their morphological character states overlap.

`taxaudit` addresses this by:
1. **Extracting discrete character states** via structured botanical ontologies (leaf shapes, margins, indumentum, flower color).
2. **Calculating Pairwise Diagnosability Index (DI)**: Evaluating whether at least one non-overlapping character state exists between species pairs.
3. **Author Mode (`ta_contrast_table()`)**: Generating automated side-by-side contrast matrices highlighting shared versus differentiating characters for taxonomists.

---

## Worked Example

```r
library(taxaudit)

# Sample species treatments
desc_a <- "Plants perennial. Leaves elliptic, margins entire, indumentum glabrous, flowers yellow."
desc_b <- "Plants perennial. Leaves lanceolate, margins serrate, indumentum glabrous, flowers white."

# 1. Extract characters
chars_a <- ta_extract_characters(desc_a)
chars_b <- ta_extract_characters(desc_b)

# 2. Calculate Pairwise Diagnosability
di_res <- ta_pairwise_di(chars_a, chars_b)
print(di_res$di_score)      # Returns 1.0 (fully diagnosable based on ontology)
print(di_res$is_diagnosable) # Returns TRUE

# 3. Generate Author Mode Contrast Table
contrast_df <- ta_contrast_table(desc_a, desc_b, "Species A", "Species B")
print(contrast_df)
```

---

## Scientific Kill Criteria

To maintain intellectual honesty, this prototype includes explicit kill criteria. The current pipeline will be deprecated or fundamentally restructured if:
1. **Extraction Precision drops below 70%** against our hand-coded gold standard subset of species due to complex syntax or nested botanical modifier clauses.
2. **Ontology bottlenecking occurs**, where >40% of morphological characters across target floras fall outside predefined ontology categories without scalable expansion.
3. **Comparison parity fails**, showing that automated pairwise DI scores correlate less with expert taxonomist judgment than baseline random selection.

---

## Installation

```r
# Install from local source
devtools::install()
```
