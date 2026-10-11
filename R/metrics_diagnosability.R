#' Calculate Pairwise Diagnosability Index (DI) between two species character profiles
#' @param chars1 Named list of character states for species 1.
#' @param chars2 Named list of character states for species 2.
#' @return A list containing the DI score and differentiating characters.
#' @export
ta_pairwise_di <- function(chars1, chars2) {
  common_categories <- intersect(names(chars1), names(chars2))
  
  diff_count <- 0
  total_compared <- 0
  differentiating_chars <- list()
  
  for (cat in common_categories) {
    set1 <- chars1[[cat]]
    set2 <- chars2[[cat]]
    
    if (length(set1) > 0 || length(set2) > 0) {
      total_compared <- total_compared + 1
      # Check for non-overlapping states
      symmetric_diff <- union(setdiff(set1, set2), setdiff(set2, set1))
      if (length(symmetric_diff) > 0) {
        diff_count <- diff_count + 1
        differentiating_chars[[cat]] <- symmetric_diff
      }
    }
  }
  
  di_score <- ifelse(total_compared > 0, diff_count / total_compared, 0)
  
  list(
    di_score = di_score,
    is_diagnosable = (di_score > 0),
    differentiating_characters = differentiating_chars
  )
}
