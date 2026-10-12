#' Fetch and Extract Morphological Characters from Flora of Pakistan Corpus
#'
#' @param taxon Character string of the taxon name (e.g. "Cedrus deodara")
#' @return A character string of the treatment description
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

#' Parse Structured Character States with High-Precision Regex
#'
#' @param text Character string of the botanical treatment
#' @return A named vector of extracted character states
#' @export
parse_characters <- function(text) {
  if (is.na(text)) return(NULL)
  
  # 1. Growth form extraction
  gf <- NA_character_
  if (grepl("Growth form:\\s*tree or large shrub", text, ignore.case = TRUE)) {
    gf <- "tree"
  } else if (grepl("tree", text, ignore.case = TRUE)) {
    gf <- "tree"
  }
  
  # 2. Helper to extract dimensional ranges following specific keywords
  extract_dimension <- function(keyword, txt) {
    # Look for keyword followed by 'measure' or text, then extract X.X-X.X pattern
    pattern <- paste0(keyword, "[^0-9]*([0-9]+\\.[0-9]+-[0-9]+\\.[0-9]+)")
cz <- regmatches(txt, regexec(pattern, txt, ignore.case = TRUE))
    if (length(cz[[1]]) >= 2) {
      return(cz[[1]][2])
    }
    return(NA_character_)
  }
  
  leaf_dim <- extract_dimension("Leaves", text)
  rep_size <- extract_dimension("Reproductive structures", text)
  if (is.na(rep_size)) rep_size <- extract_dimension("capsules", text)
  if (is.na(rep_size)) rep_size <- extract_dimension("cones", text)
  
  c(
    growth_form = gf,
    leaf_dimension_cm = leaf_dim,
    reproductive_structure_size_cm = rep_size
  )
}
