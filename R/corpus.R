#' Load the Expert-Annotated Benchmark Corpus
#'
#' @return A data frame containing gold-standard plant treatments, traits, and evidence spans.
#' @export
ta_load_corpus <- function() {
  path <- system.file('extdata', 'gold_standard_benchmark.csv', package = 'taxaudit')
  if (path == '' || !file.exists(path)) {
    # Fallback to general gold_standard.csv if benchmark file is missing
    path <- system.file('extdata', 'gold_standard.csv', package = 'taxaudit')
  }
  if (path == '' || !file.exists(path)) {
    stop('Benchmark corpus file not found in inst/extdata/. Please check package installation.')
  }
  read.csv(path, stringsAsFactors = FALSE)
}
