#' Generate a contrast table comparing character states between two taxon treatments
#' @param text1 Character string for species 1 description.
#' @param text2 Character string for species 2 description.
#' @param name1 Character. Name of species 1 (default 'Species A').
#' @param name2 Character. Name of species 2 (default 'Species B').
#' @return A data frame contrast table.
#' @export
ta_contrast_table <- function(text1, text2, name1 = 'Species A', name2 = 'Species B') {
  chars1 <- ta_extract_characters(text1)
  chars2 <- ta_extract_characters(text2)
  
  all_cats <- unique(c(names(chars1), names(chars2)))
  
  rows <- list()
  for (cat in all_cats) {
    s1 <- paste(chars1[[cat]], collapse = ', ')
    s2 <- paste(chars2[[cat]], collapse = ', ')
    if (s1 == '') s1 <- 'Not reported'
    if (s2 == '') s2 <- 'Not reported'
    
    status <- ifelse(s1 == s2, 'Shared / Overlapping', 'DIFFERENT')
    
    rows[[cat]] <- data.frame(
      Character_Category = cat,
      Taxon_1 = s1,
      Taxon_2 = s2,
      Status = status,
      stringsAsFactors = FALSE
    )
  }
  
  do.call(rbind, rows)
}
