# taxaudit: Rigorous Taxonomic Treatment Auditing Pipeline

`taxaudit` is an academic R package designed for automated extraction and auditing of morphological characters from botanical treatment texts (*Flora of Pakistan*).

## Features
- **Local Corpus Integration**: Avoids brittle web dependencies by utilizing a local directory (`inst/extdata/corpus/`) of verified botanical treatments.
- **Deterministic Regex Extraction**: Parses plant growth forms and quantitative dimensions.
- **Transparent Evaluation Engine**: Evaluates extraction performance using an automated `merge()` approach with a pre-declared numeric tolerance (`TOLERANCE = 0.1`).

## Current Evaluation & Limitations
As documented in `docs/decisions.md`, our baseline evaluation on the initial multi-sentence test set yielded:
- **True Positives**: 7
- **False Positives**: 4
- **False Negatives**: 8
- **Precision**: 0.6364 | **Recall**: 0.4667 | **F1 Score**: 0.5385

Because precision sits below our pre-declared 70% threshold, the pipeline's precision kill criterion has tripped. Per our governance model, we are actively refactoring the extractor rather than adjusting evaluation thresholds.

## License
MIT License
