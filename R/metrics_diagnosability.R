#' Calculate basic taxonomic diagnosability metrics
#' 
#' @param parsed_df Data frame containing parsed treatment text.
#' @return A data frame with added diagnosability scores.
#' @export
ta_calculate_diagnosability <- function(parsed_df) {
  if (nrow(parsed_df) == 0) {
    return(parsed_df)
  }
  
  # Simple proxy metric: presence of key diagnostic keywords or length
  # (Can be expanded later with character matrix overlaps)
  parsed_df$diagnosability_score <- pmin(1.0, parsed_df$extracted_text_length / 5000)
  parsed_df$audit_status <- ifelse(parsed_df$diagnosability_score > 0.2, "Pass", "Review Needed")
  
  return(parsed_df)
}
