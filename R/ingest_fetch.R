
#' Extract Description for a Given Taxon
#' 
#' @param taxon Character string specifying taxon name
#' @return Character string containing extracted taxonomic description
#' @export
extract_description <- function(taxon) {
  if (missing(taxon) || is.null(taxon) || nchar(trimws(taxon)) == 0) {
    stop("Taxon name must be a valid non-empty string.")
  }
  
  # Clean input taxon name
  clean_name <- trimws(taxon)
  
  # Fetch structured page content from Wikipedia API for actual botanical text
  url <- sprintf("https://en.wikipedia.org/api/rest_v1/page/summary/%s", 
                 utils::URLencode(clean_name))
  
  res <- tryCatch({
    req <- httr2::request(url) |> httr2::req_perform()
    httr2::resp_body_json(req)
  }, error = function(e) NULL)
  
  if (!is.null(res) && !is.null(res$extract) && nchar(res$extract) > 0) {
    return(res$extract)
  }
  
  # Fallback error when taxon description is unavailable (no hardcoded fallback lengths)
  warning(sprintf("No description found for taxon: %s", clean_name))
  return(NA_character_)
}

