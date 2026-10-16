#' Extract Traits with Evidence Spans and Ontology Terms
#'
#' @param text Character string containing treatment text.
#' @return A data frame containing extracted traits, character spans, and ontology metadata.
#' @export
ta_extract_traits <- function(text) {
  if (is.null(text) || nchar(trimws(text)) == 0) {
    return(data.frame(
      trait = character(0),
      val_min = numeric(0),
      val_max = numeric(0),
      unit = character(0),
      span_start = integer(0),
      span_end = integer(0),
      evidence_text = character(0),
      ontology_id = character(0),
      stringsAsFactors = FALSE
    ))
  }
  
  results <- list()
  
  # Leaf dimension regex pattern (e.g., "leaves 5-10 cm long" or "leaf 2.5-4.0 mm")
  leaf_pattern <- "(?i)\\b(leaf|leaves)\\b[^\\.\\;]*?(\\d+(?:\\.\\d+)?)\\s*-\\s*(\\d+(?:\\.\\d+)?)\\s*(cm|mm)"
  
  match_pos <- regexpr(leaf_pattern, text, perl = TRUE)
  
  if (match_pos[1] != -1) {
    match_len <- attr(match_pos, "match.length")
    span_start <- as.integer(match_pos[1])
    span_end <- as.integer(span_start + match_len - 1)
    evidence <- substr(text, span_start, span_end)
    
    # Extract numerical values from snippet
    nums <- unlist(regmatches(evidence, gregexpr("\\d+(?:\\.\\d+)?", evidence)))
    unit_match <- regmatches(evidence, regexpr("(cm|mm)", evidence, ignore.case = TRUE))
    
    results[[length(results) + 1]] <- data.frame(
      trait = "leaf_length",
      val_min = as.numeric(nums[1]),
      val_max = as.numeric(nums[2]),
      unit = ifelse(length(unit_match) > 0, tolower(unit_match[1]), NA_character_),
      span_start = span_start,
      span_end = span_end,
      evidence_text = evidence,
      ontology_id = "PO:0025034", # Plant Ontology: leaf length
      stringsAsFactors = FALSE
    )
  }
  
  if (length(results) == 0) {
    return(data.frame(
      trait = character(0), val_min = numeric(0), val_max = numeric(0),
      unit = character(0), span_start = integer(0), span_end = integer(0),
      evidence_text = character(0), ontology_id = character(0),
      stringsAsFactors = FALSE
    ))
  }
  
  do.call(rbind, results)
}