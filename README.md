<!-- badges: start -->
[![R-CMD-check](https://github.com/AamnaNaveed/taxaudit/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/AamnaNaveed/taxaudit/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/AamnaNaveed/taxaudit/actions/workflows/pkgdown.yaml/badge.svg)](https://aamnanaveed.github.io/taxaudit/)
<!-- badges: end -->

# taxaudit

[![R-CMD-check](https://github.com/AamnaNaveed/taxaudit/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/AamnaNaveed/taxaudit/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Publication-grade R package for ontology-mapped botanical trait extraction, agreement auditing, and leakage-free evaluation.

---

## 📦 Installation

```r
# install.packages("remotes")
remotes::install_github("AamnaNaveed/taxaudit")
```

### **Quick Start**
library(taxaudit)

### Load benchmark corpus & extract traits
corpus <- ta_load_corpus()
traits <- ta_extract_traits(corpus$text[1])

### Audit agreement & baseline comparison
agreement <- ta_audit_agreement(corpus)
comparison <- ta_compare_baseline(corpus)

### Leakage-free evaluation
eval_results <- ta_split_evaluation(corpus, split_by = "taxon")

<<<<<<< HEAD
## Features

- Plant Ontology (PO:0025034) alignment with exact character start/end span tracking.

- Inter-annotator agreement auditing (ta_audit_agreement).

- Leakage-free taxon-held-out cross-validation (ta_split_evaluation).

- Baseline comparison module against naive regex (ta_compare_baseline).

- Fully passes R CMD check with 0 errors | 0 warnings | 0 notes.

## 📄 License
MIT © Aamna Naveed
