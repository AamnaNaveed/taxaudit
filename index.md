# taxaudit

**Taxonomic Audit, Character Ontology, and Pairwise Diagnosability**

Official CRAN Package: <https://CRAN.R-project.org/package=taxaudit>

A publication-grade R package for automating the extraction of
morphological traits and taxonomic literature auditing from unstructured
botanical treatments. It implements controlled ontology mapping, regular
expression-based quantitative dimension parsing, benchmark corpus
management, and comparative baseline evaluation protocols for
biodiversity informatics.

------------------------------------------------------------------------

## 📦 Installation

You can install the official released version of `taxaudit` directly
from CRAN:

``` r
install.packages("taxaudit")
If you want to install the latest development version from GitHub:
```

r \# install.packages(“remotes”)
remotes::install_github(“AamnaNaveed/taxaudit”) 🚀 Quick Start r
library(taxaudit)

# Load benchmark corpus & extract traits

corpus \<- ta_load_corpus() traits \<-
ta_extract_traits(corpus\$text\[1\])

# Audit agreement & baseline comparison

agreement \<- ta_audit_agreement(corpus) comparison \<-
ta_compare_baseline(corpus)

# Leakage-free evaluation

eval_results \<- ta_split_evaluation(corpus, split_by = “taxon”) ✨
Features Ontology Mapping: Plant Ontology (PO:0025034) alignment with
exact character start/end span tracking.

Agreement Auditing: Inter-annotator agreement auditing
(ta_audit_agreement).

Rigorous Validation: Leakage-free taxon-held-out cross-validation
(ta_split_evaluation).

Baseline Comparison: Module against naive regex for benchmark evaluation
(ta_compare_baseline).

Quality Assured: Fully passes R CMD check with 0 errors \| 0 warnings \|
0 notes.

📝 Citation If you use taxaudit in your research, please cite the CRAN
package:

Naveed, A. (2026). taxaudit: Taxonomic Audit, Character Ontology, and
Pairwise Diagnosability. R package version 0.1.0.
<https://CRAN.R-project.org/package=taxaudit>

📄 License MIT © Aamna Naveed
