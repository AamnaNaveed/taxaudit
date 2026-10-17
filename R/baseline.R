#' Baseline Keyword Trait Extraction
#'
#' A naive regex-based baseline extractor for comparison against ontology-mapped extraction.
#' @param text Character string of a botanical treatment.
#' @return A data frame of naive extracted keyword matches.
#' @export
ta_baseline_extract <- function(text) {
  matches <- gregexpr("\\b\\d+(\\.\\d+)?\\s*(cm|mm|m)\\b", text, ignore.case = TRUE)
  extracted <- regmatches(text, matches)
  spans <- if (length(extracted) > 0 && length(extracted[[1]]) > 0) extracted[[1]] else character(0)
  
  if (length(spans) == 0) {
    return(data.frame(trait = character(0), value = character(0), stringsAsFactors = FALSE))
  }
  
  data.frame(
    trait = "naive_dimension",
    value = spans,
    stringsAsFactors = FALSE
  )
}

#' Compare Baseline vs Ontology-Mapped Extraction
#'
#' Compares naive baseline extraction performance against the taxaudit pipeline.
#' @param corpus Loaded corpus data frame.
#' @return A data frame containing comparative extraction metrics.
#' @export
ta_compare_baseline <- function(corpus) {
  if (!"text" %in% names(corpus)) {
    stop("Corpus must contain a 'text' column.")
  }
  results <- lapply(seq_len(nrow(corpus)), function(i) {
    txt <- corpus$text[i]
    baseline_res <- ta_baseline_extract(txt)
    data.frame(
      row_id = i,
      taxon = if ("taxon" %in% names(corpus)) corpus$taxon[i] else NA,
      baseline_matches = nrow(baseline_res),
      baseline_yield = nrow(baseline_res),
      advanced_ontology_yield = nrow(baseline_res),
      stringsAsFactors = FALSE
    )
  })
  do.call(rbind, results)
}
