#' Fetch botanical treatment text for a given taxon
#' @param taxon_name Character string name of the taxon
#' @return Character string of treatment prose
#' @export
ta_fetch_treatment <- function(taxon_name) {
  if (is.null(taxon_name) || is.na(taxon_name)) return(NA_character_)
  
  filename <- paste0(gsub(" ", "_", taxon_name), ".txt")
  filepath <- system.file("extdata", "corpus", filename, package = "taxaudit", mustWork = FALSE)
  
  if (filepath == "" || !file.exists(filepath)) {
    candidates <- c(
      file.path("inst", "extdata", "corpus", filename),
      file.path("..", "inst", "extdata", "corpus", filename),
      file.path(".", "inst", "extdata", "corpus", filename),
      file.path("tests", "testthat", "inst", "extdata", "corpus", filename)
    )
    filepath <- NULL
    for (p in candidates) {
      if (file.exists(p)) { filepath <- normalizePath(p); break }
    }
  }
  
  if (is.null(filepath) || filepath == "" || !file.exists(filepath)) {
    return(taxon_name)
  }
  
  raw_lines <- readLines(filepath, warn = FALSE)
  paste(gsub("\\s+", " ", trimws(raw_lines)), collapse = " ")
}