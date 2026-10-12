# taxaudit: Rigorous Taxonomic Treatment Auditing Pipeline

`taxaudit` is an academic R package designed for high-integrity, automated extraction and auditing of morphological characters from botanical treatment texts (specifically targeting the *Flora of Pakistan*).

## Features
- **Immutable Local Corpus**: Eliminates flaky web APIs by utilizing a local directory (`inst/extdata/corpus/`) of verified botanical treatments.
- **Robust Regex Extraction**: Parses plant growth forms and quantitative dimensions (leaf and reproductive structure sizes).
- **Rigorous Evaluation Engine**: Evaluates extraction performance using an automated `merge()`-based approach with a pre-declared numeric tolerance (`TOLERANCE = 0.1`) to prevent post-hoc tuning.

## Installation & Verification
Clone the repository and run the evaluation script directly in R:

```r
setwd("path/to/taxaudit")
source("R/extractor.R")

# Test ingestion and parsing
desc <- extract_description("Cedrus deodara")
print(parse_characters(desc))
```

## Running the Benchmark Evaluation
To reproduce the benchmark performance metrics:

```r
source("inst/extdata/run_evaluation.R") # if applicable, or run your evaluation script
```

## License
MIT License
