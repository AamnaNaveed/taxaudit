#' Fetch and Extract Morphological Characters from Flora of Pakistan Corpus
#'
#' @param taxon Character string of the taxon name (e.g. "Cedrus deodara")
#' @return A character string of the treatment description or a structured summary
#' @export
extract_description <- function(taxon) {
  safe_name <- gsub(" ", "_", taxon)
  corpus_path <- system.file("extdata", "corpus", paste0(safe_name, ".txt"), package = "taxaudit")
  
  if (corpus_path == "" || !file.exists(corpus_path)) {
    local_path <- file.path("inst", "extdata", "corpus", paste0(safe_name, ".txt"))
    if (file.exists(local_path)) {
      corpus_path <- local_path
    } else {
      warning("Taxon treatment not found in corpus: ", taxon)
      return(NA_character_)
    }
  }
  
  treatment_text <- readLines(corpus_path, warn = FALSE)
  paste(treatment_text, collapse = " ")
}

#' Parse Structured Character States from Treatment Text
#'
#' @param text Character string of the botanical treatment
#' @return A named vector of extracted character states
#' @export
parse_characters <- function(text) {
  if (is.na(text)) return(NULL)
  
  # Extract growth form
  gf <- if (grepl("tree", text, ignore.case = TRUE)) "tree" else "shrub"
  if (grepl("shrub or tree", text, ignore.case = TRUE)) gf <- "shrub_or_tree"
  if (grepl("tree or shrub", text, ignore.case = TRUE)) gf <- "tree_or_shrub"
  
  # Find all numeric range patterns e.g. '2.5-5.0'
  matches <- regmatches(text, gregexpr("[0-9]+\\.[0-9]+-[0-9]+\\.[0-9]+", text))[[1]]
  
  leaf_dim <- if (length(matches) >= 1) matches[1] else NA_character_
  rep_size <- if (length(matches) >= 2) matches[2] else NA_character_
  
  c(
    growth_form = gf,
    leaf_dimension_cm = leaf_dim,
    reproductive_structure_size_cm = rep_size
  )
}
