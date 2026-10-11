
#' Calculate Pairwise Diagnosability Index
#' 
#' @param taxon_a Character or numeric vector of character states for taxon A
#' @param taxon_b Character or numeric vector of character states for taxon B
#' @return A numeric value representing the Diagnosability Index (0 = identical, 1 = fully disjoint)
#' @export
calculate_DI <- function(taxon_a, taxon_b) {
  # Remove positions where either taxon has NA (NA never counts as a contrast)
  valid_idx <- !is.na(taxon_a) & !is.na(taxon_b)
  if (sum(valid_idx) == 0) return(NA_real_)
  
  a <- taxon_a[valid_idx]
  b <- taxon_b[valid_idx]
  
  total <- length(a)
  if (total == 0) return(0)
  
  # Helper to check if states differ (supports exact match or non-overlapping numeric ranges)
  states_differ <- function(val1, val2) {
    if (identical(val1, val2)) return(FALSE)
    
    # Check if both can be parsed as numeric ranges (e.g. "2-5" or numeric vectors)
    parse_range <- function(x) {
      if (is.numeric(x)) return(range(x))
      if (is.character(x) && grepl("-", x)) {
        parts <- as.numeric(strsplit(x, "-")[[1]])
        if (length(parts) == 2 && !any(is.na(parts))) return(range(parts))
      }
      return(NULL)
    }
    
    r1 <- parse_range(val1)
    r2 <- parse_range(val2)
    
    if (!is.null(r1) && !is.null(r2)) {
      # Ranges contrast if they do not overlap
      return(r1[2] < r2[1] || r2[2] < r1[1])
    }
    
    return(val1 != val2)
  }
  
  disagree_count <- sum(mapply(states_differ, a, b))
  return(disagree_count / total)
}

