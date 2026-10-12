# Architectural Decision Record: Handling Precision Kill Criterion

## Status
**Triggered / Active** (Date: 2026-10-20)

## Context
The package baseline evaluation yielded an F1 score of 0.5385 with Precision at 0.6364 and Recall at 0.4667 across the initial multi-sentence corpus subset. 
Our pre-declared project threshold set a precision floor of 70% (0.70). Because the empirical precision (0.636) falls below this boundary, the pipeline's precision kill criterion has officially tripped.

## Decision
1. **Do not move the threshold:** We reject post-hoc tuning or arbitrary threshold relaxation to manufacture a passing score.
2. **Log and Refactor:** We formally log this failure state in this ADR. Rather than altering evaluation parameters, engineering efforts will target the extractor regex logic to systematically reduce False Positives and False Negatives.
3. **Dataset Expansion & Held-Out Split:** Scale the corpus toward 25+ taxa and establish a strictly held-out test split to prevent data leakage during ongoing regex iteration.

## Consequences
The package transparently acknowledges its current limitations in the README. Future commits will implement error-type sorting (unit mismatches vs. missing characters) to guide deterministic parser improvements.

## Progress Update (2026-10-22)
Following context-anchored regex refinement, evaluation on the pristine held-out test set yielded:
- **Precision**: 0.6667
- **Recall**: 0.6667
- **F1 Score**: 0.6667
Precision is now within striking distance of the 70% threshold, demonstrating that systematic parser refinement successfully targets false positives without overfitting.
