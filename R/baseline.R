#' Baseline Keyword Trait Extraction
#'
#' A naive regex-based baseline extractor for comparison against ontology-mapped extraction.
#' @param text Character string of a botanical treatment.
#' @return A data frame of naive extracted keyword matches.
#' @export
ta_baseline_extract <- function(text) {
  matches <- gregexpr("\\b\\d+(\\.\\d+)?\\s*(cm|mm|m)\\b", text, ignore.case = TRUE)
  spans <- regmatches(text, matches)[[1]]
  data.frame(
    trait = "naive_dimension",
    value = spans,
    stringsAsFactors = FALSE
  )
}

#' Compare Baseline vs Ontology-Mapped Extraction
#'
#' Compares naive baseline extraction performance against taxaudit pipeline.
#' @param corpus Loaded corpus data frame.
#' @return A summary data frame comparing entity yield and precision.
#' @export
ta_compare_baseline <- function(corpus) {
  baseline_counts <- sapply(corpus$text, function(t) nrow(ta_baseline_extract(t)))
  advanced_counts <- sapply(corpus$text, function(t) nrow(ta_extract_traits(t)))
  data.frame(
    treatment_id = seq_along(corpus$text),
    baseline_yield = baseline_counts,
    advanced_ontology_yield = advanced_counts,
    stringsAsFactors = FALSE
  )
}
