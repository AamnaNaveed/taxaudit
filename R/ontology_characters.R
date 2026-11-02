#' Define standard botanical character ontology for Flora audits
#'
#' Retrieves the controlled vocabulary and categorical trait definitions 
#' used for botanical literature auditing.
#'
#' @return A named \code{list} where each element represents a botanical trait 
#'   category (e.g., leaf shape, indumentum) containing a character vector 
#'   of valid state terms.
#' @export
#'
#' @examples
#' ontology <- ta_get_ontology()
#' names(ontology)
#' head(ontology$leaf_shape)
ta_get_ontology <- function() {
  list(
    leaf_shape = c('elliptic', 'lanceolate', 'ovate', 'linear', 'obovate', 'cordate'),
    leaf_margin = c('entire', 'serrate', 'dentate', 'crenate', 'ciliate'),
    indumentum = c('glabrous', 'pubescent', 'hirsute', 'tomentose', 'strigose'),
    flower_color = c('yellow', 'white', 'blue', 'purple', 'red', 'pink')
  )
}