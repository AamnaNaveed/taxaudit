#' Extract characters from taxon description text with expanded ontology
#' @param text Character string of the taxon description.
#' @return A list of character categories and extracted states.
#' @export
ta_extract_characters <- function(text) {
  text_lower <- tolower(text)
  extract_state <- function(patterns) {
    matches <- sapply(patterns, function(p) grepl(p, text_lower))
    if (any(matches)) names(patterns)[matches] else character(0)
  }
  list(
    life_form = extract_state(c(annual = 'annual', biennial = 'biennial', perennial = 'perennial')),
    leaf_shape = extract_state(c(elliptic = 'elliptic', lanceolate = 'lanceolate', ovate = 'ovate', linear = 'linear')),
    leaf_margin = extract_state(c(entire = 'entire', serrate = 'serrate', dentate = 'dentate', lobed = 'lobed')),
    leaf_arrangement = extract_state(c(alternate = 'alternate', opposite = 'opposite', whorled = 'whorled', basal = 'basal')),
    indumentum = extract_state(c(glabrous = 'glabrous', pubescent = 'pubescent', tomentose = 'tomentose', villous = 'villous')),
    flower_color = extract_state(c(yellow = 'yellow', white = 'white', blue = 'blue', purple = 'purple', red = 'red')),
    fruit_type = extract_state(c(capsule = 'capsule', achene = 'achene', follicle = 'follicle', legume = 'legume', berry = 'berry'))
  )
}
