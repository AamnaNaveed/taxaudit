#' Split Corpus Data for Held-Out Evaluation
#'
#' @param corpus_df Data frame containing the annotated corpus (must include columns like taxon and source).
#' @param holdout_type Character string: either "taxon" or "source".
#' @param target_holdout Value of the taxon or source to hold out (e.g., "Cedrus deodara" or "Flora of Pakistan Vol 2").
#' @return A list with training/evaluation data splits.
#' @export
ta_split_evaluation <- function(corpus_df, holdout_type = c("taxon", "source"), target_holdout) {
  holdout_type <- match.arg(holdout_type)
  
  if (holdout_type == "taxon") {
    test_set <- corpus_df[corpus_df$taxon == target_holdout, ]
    train_set <- corpus_df[corpus_df$taxon != target_holdout, ]
  } else {
    test_set <- corpus_df[corpus_df$source == target_holdout, ]
    train_set <- corpus_df[corpus_df$source != target_holdout, ]
  }
  
  list(
    train = train_set,
    test = test_set,
    holdout_type = holdout_type,
    target = target_holdout
  )
}