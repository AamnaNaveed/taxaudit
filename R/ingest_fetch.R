#' Fetch taxonomic treatment pages politely
#' 
#' @param url Character. The target URL of the treatment.
#' @param cache_dir Character. Local directory to cache raw HTML.
#' @return Character path to the cached file.
#' @export
ta_fetch_treatment <- function(url, cache_dir = "data-raw/cache") {
  if (!dir.exists(cache_dir)) dir.create(cache_dir, recursive = TRUE, showWarnings = FALSE)
  
  # Create a safe filename from the URL hash
  file_hash <- digest::digest(url, algo = "sha256")
  dest_file <- file.path(cache_dir, paste0(file_hash, ".html"))
  
  if (file.exists(dest_file)) {
    message("Using cached file for: ", url)
    return(dest_file)
  }
  
  # Polite request with httr2
  req <- httr2::request(url) %>%
    httr2::req_user_agent("taxaudit-bot (Open source taxonomic audit research)") %>%
    httr2::req_retry(max_tries = 3, backoff = ~ 2) %>%
    httr2::req_throttle(rate = 1)
  
  resp <- httr2::req_perform(req)
  httr2::resp_body_string(resp) %>% writeLines(dest_file)
  
  message("Successfully fetched and cached: ", url)
  return(dest_file)
}
