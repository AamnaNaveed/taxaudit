#' Resolve and Standardize Taxonomic Names
#' @param taxon_names Character vector of taxon names to resolve.
#' @param synonym_db Optional data frame containing 'Synonym' and 'Accepted' columns. If NULL, uses built-in default mappings.
#' @return A data frame containing original names, resolved accepted names, and resolution status.
#' @export
ta_resolve_names <- function(taxon_names, synonym_db = NULL) {
  if (is.null(synonym_db)) {
    synonym_db <- data.frame(
      Synonym = c('Ranunculus sceleratus var. indica', 'Polygonum plebeium var. elegans', 'Rosa webbiana var. microphylla'),
      Accepted = c('Ranunculus sceleratus', 'Polygonum plebeium', 'Rosa webbiana'),
      stringsAsFactors = FALSE
    )
  }
  
  resolved_df <- data.frame(
    Original_Name = taxon_names,
    Accepted_Name = taxon_names,
    Status = 'Accepted',
    stringsAsFactors = FALSE
  )
  
  for (i in seq_along(taxon_names)) {
    match_idx <- match(taxon_names[i], synonym_db$Synonym)
    if (!is.na(match_idx)) {
      resolved_df$Accepted_Name[i] <- synonym_db$Accepted[match_idx]
      resolved_df$Status[i] <- 'Synonym Resolved'
    }
  }
  
  return(resolved_df)
}
