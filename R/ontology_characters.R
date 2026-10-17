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
