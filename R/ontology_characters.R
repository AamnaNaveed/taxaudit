#' Define standard botanical character ontology for Flora audits
#' @export
ta_get_ontology <- function() {
  list(
    leaf_shape = c('elliptic', 'lanceolate', 'ovate', 'linear', 'obovate', 'cordate'),
    leaf_margin = c('entire', 'serrate', 'dentate', 'crenate', 'ciliate'),
    indumentum = c('glabrous', 'pubescent', 'hirsute', 'tomentose', 'strigose'),
    flower_color = c('yellow', 'white', 'blue', 'purple', 'red', 'pink')
  )
}

#' Extract discrete character states from treatment text based on ontology
#' @param text Character string of the treatment description.
#' @return A named list of detected character states.
#' @export
ta_extract_characters <- function(text) {
  ontology <- ta_get_ontology()
  extracted <- list()
  
  text_lower <- tolower(text)
  
  for (char_category in names(ontology)) {
    possible_states <- ontology[[char_category]]
    found_states <- possible_states[sapply(possible_states, function(state) grepl(state, text_lower, fixed = TRUE))]
    extracted[[char_category]] <- found_states
  }
  
  return(extracted)
}
