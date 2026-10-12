#' Fetch and Extract Morphological Characters from Flora of Pakistan Corpus
#'
#' @param taxon Character string of the taxon name
#' @return Character string of treatment description
#' @export
extract_description <- function(taxon) {
  safe_name <- gsub(" ", "_", taxon)
  corpus_path <- system.file("extdata", "corpus", paste0(safe_name, ".txt"), package = "taxaudit")
  
  if (corpus_path == "" || !file.exists(corpus_path)) {
    local_path <- file.path("inst", "extdata", "corpus", paste0(safe_name, ".txt"))
    if (file.exists(local_path)) {
      corpus_path <- local_path
    } else {
      return(NA_character_)
    }
  }
  treatment_text <- readLines(corpus_path, warn = FALSE)
  paste(treatment_text, collapse = " ")
}

#' Parse Structured Character States
#' @param text Character string of treatment
#' @return Named vector of extracted states
#' @export
parse_characters <- function(text) {
  if (is.na(text)) return(NULL)
  
  gf <- if (grepl("Growth form:\\s*tree", text, ignore.case = TRUE)) "tree" else NA_character_
  
  extract_dim <- function(keyword, txt) {
    pattern <- paste0(keyword, "[^0-9]*([0-9]+\\.[0-9]+-[0-9]+\\.[0-9]+)")
    res <- regmatches(txt, regexec(pattern, txt, ignore.case = TRUE))
    if (length(res[[1]]) >= 2) return(res[[1]][2])
    return(NA_character_)
  }
  
  leaf_dim <- extract_dim("Leaves", text)
  rep_size <- extract_dim("Reproductive structures", text)
  
  c(
    growth_form = gf,
    leaf_dimension_cm = leaf_dim,
    reproductive_structure_size_cm = rep_size
  )
}
