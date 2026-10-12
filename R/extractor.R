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

#' Parse Structured Character States from Treatment Text with Context Anchors
#'
#' @param text Character string of the botanical treatment
#' @return A named vector of extracted character states
#' @export
parse_characters <- function(text) {
  if (is.na(text)) return(NULL)
  
  # Extract growth form
  gf <- if (grepl("tree", text, ignore.case = TRUE)) "tree" else "shrub"
  if (grepl("tree or large shrub", text, ignore.case = TRUE)) gf <- "tree_or_shrub"
  
  # Context-anchored extraction for leaves and reproductive structures
  extract_near <- function(keyword, txt) {
    pos <- regexpr(keyword, txt, ignore.case = TRUE)
    if (pos == -1) return(NA_character_)
    # Extract a substring window around the keyword
    window <- substr(txt, max(1, pos - 20), min(nchar(txt), pos + 80))
    matches <- regmatches(window, gregexpr("[0-9]+\\.[0-9]+-[0-9]+\\.[0-9]+", window))[[1]]
    if (length(matches) > 0) return(matches[1])
    return(NA_character_)
  }
  
  leaf_dim <- extract_near("leaves", text)
  rep_size <- extract_near("reproductive", text)
  if (is.na(rep_size)) rep_size <- extract_near("capsules", text)
  if (is.na(rep_size)) rep_size <- extract_near("cones", text)
  
  c(
    growth_form = gf,
    leaf_dimension_cm = leaf_dim,
    reproductive_structure_size_cm = rep_size
  )
}
