# taxaudit 0.1.0

* Initial public release of `taxaudit`.
* Added curated benchmark corpus loading (`ta_load_corpus`) mapped to Plant Ontology (`PO:0025034`).
* Implemented span-based trait extraction (`ta_extract_traits`) with exact character coordinates.
* Added inter-annotator agreement auditing (`ta_audit_agreement`).
* Integrated baseline regex comparison module (`ta_compare_baseline`, `ta_baseline_extract`).
* Added leakage-free cross-validation split evaluation (`ta_split_evaluation`).
* Fully verified with passing unit tests (`testthat`) and clean `R CMD check` (0 errors, 0 warnings, 0 notes).
