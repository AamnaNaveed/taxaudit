# taxaudit: Botanical Trait Extraction & Diagnosability

**Status:** Working Prototype (Experimental)  
**R CMD Check:** Passing (`0 errors | 0 warnings | 0 notes`)

`taxaudit` is an academic R package designed for automated extraction and auditing of morphological characters from botanical treatment texts (*Flora of Pakistan*).

> **Important Scope Note:** While the package infrastructure passes `R CMD check` cleanly, **software build compliance does not imply biological extraction accuracy.** Extraction performance and diagnosability metrics remain under active development and benchmarking.

---

## Features
- **Local Corpus Integration**: Avoids brittle web dependencies by utilizing a local directory (`inst/extdata/corpus/`) of verified botanical treatments.
- **Deterministic Regex Extraction**: Parses plant growth forms and quantitative dimensions using safe Unicode range parsing (`parse_botanical_range()`).
- **Transparent Evaluation Engine**: Evaluates extraction performance using an automated approach with a pre-declared numeric tolerance (`TOLERANCE = 0.1`).

---

## Current Evaluation & Limitations

As documented in `docs/decisions.md`, our baseline evaluation on the initial multi-sentence test set yielded:
- **True Positives**: 7
- **False Positives**: 4
- **False Negatives**: 8
- **Precision**: 0.6364 | **Recall**: 0.4667 | **F1 Score**: 0.5385

### 1. Kill Criterion Status
Because precision sits below our pre-declared 70% threshold, **the pipeline's precision kill criterion has tripped**. Per our governance model, we are actively refactoring the extractor rather than adjusting evaluation thresholds.

### 2. Taxa Scope & Congener Limitations
* **Corpus Scope:** The current test set spans species across different genera (e.g., *Cedrus deodara*, *Pinus roxburghii*, *Quercus incana* from the *Flora of Pakistan*). 
* **Limitation:** Cross-genera evaluations serve only as a **structural smoke test** for the pipeline. They do not rigorously test diagnosability (`calculate_DI`). True phenotypic contrast requires fine-grained evaluation among true **congeners** (multiple species within the same genus), which is the target for subsequent refactoring cycles.

---

## Core Workflow

```r
library(taxaudit)

# 1. Fetch treatment text from local corpus or taxon name
treatment_text <- ta_fetch_treatment("Cedrus deodara")

# 2. Extract phenotypic traits using the core extraction engine
traits <- ta_extract_traits(treatment_text)

# 3. Run a complete audit wrapper
audit_results <- ta_run_audit("Cedrus deodara")
print(audit_results$extracted_traits)