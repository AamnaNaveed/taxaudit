#' Load the Expert-Annotated Benchmark Corpus
#'
#' @return A data frame containing gold-standard plant treatments, traits, and evidence spans.
#' @export
ta_load_corpus <- function() {
  path <- system.file('extdata', 'gold_standard_benchmark.csv', package = 'taxaudit')
  if (path == '' || !file.exists(path)) {
    path <- system.file('extdata', 'gold_standard.csv', package = 'taxaudit')
  }
  if (path == '' || !file.exists(path)) {
    stop('Benchmark corpus file not found in inst/extdata/.')
  }
  df <- read.csv(path, stringsAsFactors = FALSE)
  
  # Standardize column names to lowercase
  orig_names <- names(df)
  names(df) <- tolower(names(df))
  
  # Find text column
  if (!"text" %in% names(df)) {
    text_candidates <- c("treatment_text", "description", "text_content", "content")
    match_idx <- which(names(df) %in% text_candidates)
    if (length(match_idx) > 0) {
      df$text <- df[[match_idx[1]]]
    } else {
      # Pick the longest string column as fallback
      char_cols <- sapply(df, is.character)
      if (any(char_cols)) {
        df$text <- df[[which(char_cols)[1]]]
      }
    }
  }
  
  # Find taxon column
  if (!"taxon" %in% names(df)) {
    taxon_candidates <- c("species", "taxon_name", "name", "plant")
    match_idx <- which(names(df) %in% taxon_candidates)
    if (length(match_idx) > 0) {
      df$taxon <- df[[match_idx[1]]]
    } else {
      df$taxon <- "Unknown taxon"
    }
  }
  
  df
}
