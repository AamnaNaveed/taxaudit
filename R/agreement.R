#' Calculate Agreement and Overlap Between Two Annotation Sets
#'
#' @param annotations_a Data frame from Annotator A (must include trait, span_start, span_end).
#' @param annotations_b Data frame from Annotator B (must include trait, span_start, span_end).
#' @return A list containing matching statistics and agreement score.
#' @export
ta_audit_agreement <- function(annotations_a, annotations_b) {
  if (nrow(annotations_a) == 0 && nrow(annotations_b) == 0) {
    return(list(agreement_score = 1.0, matched_count = 0, total_a = 0, total_b = 0))
  }
  
  matched <- 0
  for (i in seq_len(nrow(annotations_a))) {
    row_a <- annotations_a[i, ]
    # Check if any annotation in B matches trait and overlaps in character span
    hit <- which(
      annotations_b$trait == row_a$trait &
        !(annotations_b$span_end < row_a$span_start | annotations_b$span_start > row_a$span_end)
    )
    if (length(hit) > 0) {
      matched <- matched + 1
    }
  }
  
  total_possible <- max(nrow(annotations_a), nrow(annotations_b))
  score <- ifelse(total_possible > 0, matched / total_possible, 0.0)
  
  list(
    agreement_score = score,
    matched_count = matched,
    total_a = nrow(annotations_a),
    total_b = nrow(annotations_b)
  )
}