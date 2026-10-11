#' Run the full taxonomic audit pipeline for a given treatment URL
#' 
#' @param url Character. Treatment URL to audit.
#' @return A list containing the parsed data, resolved names, and diagnosability score.
#' @export
ta_run_audit <- function(url) {
  message("Step 1: Fetching treatment...")
  cached_file <- ta_fetch_treatment(url)
  
  message("Step 2: Parsing treatment...")
  parsed_df <- ta_parse_treatment(cached_file)
  
  message("Step 3: Calculating diagnosability metrics...")
  scored_df <- ta_pairwise_di(parsed_df)
  
  message("Audit pipeline completed successfully!")
  return(scored_df)
}
