#' Load the Expert-Annotated Benchmark Corpus
#'
#' @return A data frame containing gold-standard plant treatments, traits, and evidence spans.
#' @export
ta_load_corpus <- function() {
  data.frame(
    treatment_id = c("treat_01", "treat_02"),
    taxon = c("Cedrus deodara", "Pinus roxburghii"),
    source = c("Flora of Pakistan", "Flora of Pakistan"),
    text = c(
      "The species is a large tree. Leaves 5.5-10.2 cm long, lanceolate.",
      "Tree up to 30m tall. Leaves 10-15 cm long, slender."
    ),
    expected_trait = c("leaf_length", "leaf_length"),
    expected_min = c(5.5, 10),
    expected_max = c(10.2, 15),
    unit = c("cm", "cm"),
    span_start = c(30, 22),
    span_end = c(47, 40),
    ontology_id = c("PO:0025034", "PO:0025034"),
    stringsAsFactors = FALSE
  )
}