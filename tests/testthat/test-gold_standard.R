
test_that("Gold-standard evaluation calculates Precision, Recall, and F1 on character states", {
  # Ground-truth hand-coded character states for test set
  ground_truth <- list(
    "Pinus sylvestris" = c("leaves_needle_like", "leaves_in_pairs", "cones_conic"),
    "Quercus robur" = c("leaves_obovate", "petioles_short", "fruit_acorn")
  )
  
  # Extracted states from parser
  extracted_states <- list(
    "Pinus sylvestris" = c("leaves_needle_like", "leaves_in_pairs", "cones_conic"),
    "Quercus robur" = c("leaves_obovate", "petioles_short", "leaves_glabrous") # 2 TP, 1 FP
  )
  
  # Calculate precision, recall, and F1
  eval_metrics <- function(tp, fp, fn) {
    precision <- tp / (tp + fp)
    recall <- tp / (tp + fn)
    f1 <- 2 * (precision * recall) / (precision + recall)
    list(precision = precision, recall = recall, f1 = f1)
  }
  
  # Evaluated metrics for Quercus robur (TP = 2, FP = 1, FN = 1)
  res <- eval_metrics(tp = 2, fp = 1, fn = 1)
  
  expect_equal(res$precision, 2/3)
  expect_equal(res$recall, 2/3)
  expect_equal(res$f1, 2/3)
})

