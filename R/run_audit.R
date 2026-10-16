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
  
  # Updated to neutral, professional naming
  traits <- ta_extract_traits(treatment_text)
  
  list(
    taxon = taxon,
    treatment_text = treatment_text,
    extracted_traits = traits,
    audit_timestamp = Sys.time()
  )
}