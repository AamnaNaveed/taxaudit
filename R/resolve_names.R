#' Clean and resolve taxonomic names
#' 
#' @param names_vector Character vector of raw taxons.
#' @return A data frame with original and cleaned names.
#' @export
ta_resolve_names <- function(names_vector) {
  if (length(names_vector) == 0) {
    return(data.frame(raw_name = character(0), cleaned_name = character(0), stringsAsFactors = FALSE))
  }
  
  # Basic string cleaning (strip trailing whitespace, authors if standard, etc.)
  cleaned <- trimws(names_vector)
  
  result <- data.frame(
    raw_name = names_vector,
    cleaned_name = cleaned,
    resolved_status = "Pending Check",
    stringsAsFactors = FALSE
  )
  
  return(result)
}
