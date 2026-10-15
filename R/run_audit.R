#' Fetch botanical treatment for auditing
#' @param taxon_or_path Character string of taxon name or file path
#' @return Character string of treatment description
#' @export
ta_fetch_treatment <- function(taxon_or_path) {
  if (is.null(taxon_or_path) || is.na(taxon_or_path)) return(NA_character_)
  
  if (file.exists(taxon_or_path)) {
    paste(readLines(taxon_or_path, warn = FALSE), collapse = " ")
  } else {
    extract_description(taxon_or_path)
  }
}

#' Run a complete botanical trait audit for a taxon
#' @param taxon Character string name of the taxon or path to treatment file
#' @return A structured list containing audit results and extracted traits
#' @export
ta_run_audit <- function(taxon) {
  if (is.null(taxon) || is.na(taxon)) return(NULL)
  
  treatment_text <- ta_fetch_treatment(taxon)
  if (is.na(treatment_text) || nchar(trimws(treatment_text)) == 0) {
    warning("No treatment text found for taxon: ", taxon)
    return(NULL)
  }
  
  traits <- extract_real_traits(treatment_text)
  
  list(
    taxon = taxon,
    treatment_text = treatment_text,
    extracted_traits = traits,
    audit_timestamp = Sys.time()
  )
}