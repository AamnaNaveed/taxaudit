# taxaudit 🌿

`taxaudit` is a specialized, production-grade R package designed for automated botanical trait extraction and rigorous benchmark auditing from taxonomic treatments (such as the *Flora of Pakistan* corpus). 

The package prioritizes high-accuracy extraction backed by an automated evaluation pipeline, strict numerical tolerance bounds, and robust handling of compound growth forms.

---

## Installation

You can install the development version of `taxaudit` locally from your package directory using `devtools`:

```r
# Ensure devtools is installed
install.packages("devtools")

# Load or install taxaudit locally
devtools::install()

Features
Context-Anchored Organ Feature Extractor: Extracts morphological traits (growth forms, leaf dimensions, and reproductive structure sizes) from unstructured taxonomic treatment text.

Automated Benchmark Auditing: Evaluates extractions against a gold standard dataset (gold_standard.csv) calculating Precision, Recall, and F1 Score.

Tolerance-Aware Range Matching: Evaluates numerical ranges against extreme and typical bounds using a strict tolerance threshold (TOLERANCE = 0.1).

Zero-Defect Standard: Fully verified against R CMD standards with 0 errors, 0 warnings, and 0 notes.
Quick Start & Benchmarking
To run the full automated benchmark evaluation and view your Precision, Recall, and F1 performance metrics, execute the benchmark script included in the package:

R
library(taxaudit)

# Run the benchmark evaluation suite
source("inst/scripts/evaluate_extraction.R")
run_benchmark_audit()
Example Extraction
R
library(taxaudit)

# Fetch or pass treatment text for a target taxon
treatment <- ta_fetch_treatment("Cedrus deodara")

# Extract structured botanical traits
traits <- ta_extract_traits(treatment)
print(traits)
Package Structure
R/: Core package functions (extractor.R, fetcher.R, etc.)

inst/extdata/: Corpus treatments and gold standard CSV files (gold_standard.csv).

inst/scripts/: Automated evaluation and auditing scripts (evaluate_extraction.R).

vignettes/: Detailed package documentation and usage guides.

License
MIT © 2026 taxaudit Contributors.