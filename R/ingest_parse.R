#' Parse a cached taxonomic treatment HTML file
#'
#' @param html_path Character. Path to the cached HTML file.
#' @return A data frame containing extracted treatment text and status.
#' @export
ta_parse_treatment <- function(html_path) {
  if (!file.exists(html_path)) {
    stop('HTML file not found: ', html_path)
  }
  
  page <- xml2::read_html(html_path)
  raw_text <- rvest::html_text(rvest::html_node(page, 'body'))
  
  # Check for eFloras error boilerplate
  if (grepl('Can not find this taxon in database', raw_text, fixed = TRUE)) {
    warning('Fetched page indicates taxon not found in database: ', html_path)
    return(data.frame(
      file_path = html_path,
      extracted_text = '',
      extracted_text_length = 0,
      valid_treatment = FALSE,
      parsed_at = as.character(Sys.time()),
      stringsAsFactors = FALSE
    ))
  }
  
  # Clean up whitespace/newlines
  cleaned_text <- trimws(gsub('\\s+', ' ', raw_text))
  
  result <- data.frame(
    file_path = html_path,
    extracted_text = cleaned_text,
    extracted_text_length = nchar(cleaned_text),
    valid_treatment = TRUE,
    parsed_at = as.character(Sys.time()),
    stringsAsFactors = FALSE
  )
  
  return(result)
}
