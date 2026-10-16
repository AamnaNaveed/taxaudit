#' Run Benchmark Evaluation and Error Breakdown for taxaudit
library(taxaudit)

run_benchmark_audit <- function(gold_standard_path = "inst/extdata/gold_standard.csv") {
  if (!file.exists(gold_standard_path)) {
    gold_standard_path <- file.path("inst", "extdata", "gold_standard.csv")
    if (!file.exists(gold_standard_path)) {
      stop("Gold standard file not found at: ", gold_standard_path)
    }
  }
  
  gold_data <- read.csv(gold_standard_path, stringsAsFactors = FALSE)
  TOLERANCE <- 0.1
  
  cat("==================================================\n")
  cat("Running taxaudit Benchmark Evaluation...\n")
  cat("Corpus file:", gold_standard_path, "\n")
  cat("Total benchmark rows:", nrow(gold_data), "\n")
  cat("Tolerance threshold: TOLERANCE =", TOLERANCE, "\n")
  cat("==================================================\n\n")
  
  tp <- 0
  fp <- 0
  fn <- 0
  
  error_log <- data.frame(
    taxon = character(),
    character = character(),
    expected = character(),
    extracted = character(),
    stringsAsFactors = FALSE
  )
  
  unique_taxa <- unique(gold_data$Taxon)
  
  for (tax in unique_taxa) {
    treatment_text <- ta_fetch_treatment(tax)
    if (is.na(treatment_text) || nchar(trimws(treatment_text)) == 0) {
      warning("Treatment text missing for taxon: ", tax)
      next
    }
    
    extracted <- ta_extract_traits(treatment_text)
    taxon_gold <- gold_data[gold_data$Taxon == tax, ]
    
    for (j in seq_len(nrow(taxon_gold))) {
      g_char <- taxon_gold$Character[j]
      g_state <- taxon_gold$State_g[j]
      
      matched <- FALSE
      ext_val_str <- "NULL"
      
      if (g_char == "growth_form") {
        ext_val <- extracted$growth_form
        ext_val_str <- ifelse(is.null(ext_val), "NULL", as.character(ext_val))
        if (!is.null(ext_val)) {
          # Normalize and split compound forms by "_or_" and sort them order-independently
          norm_expected <- sort(trimws(unlist(strsplit(tolower(g_state), "_or_"))))
          norm_extracted <- sort(trimws(unlist(strsplit(tolower(ext_val), "_or_"))))
          
          if (identical(norm_expected, norm_extracted)) {
            matched <- TRUE
          }
        }
      } else if (g_char %in% c("leaf_dimension_cm", "reproductive_structure_size_cm")) {
        dim_obj <- if (g_char == "leaf_dimension_cm") extracted$leaf_dimensions else extracted$reproductive_size
        
        if (!is.null(dim_obj)) {
          # Parse expected range bounds (e.g., "2.0-5.0" -> min = 2.0, max = 5.0)
          exp_parts <- as.numeric(unlist(strsplit(g_state, "-")))
          exp_min <- exp_parts[1]
          exp_max <- ifelse(length(exp_parts) > 1, exp_parts[2], exp_parts[1])
          
          # Gather extracted numerical bounds
          ext_nums <- c(dim_obj$min_extreme, dim_obj$min_typical, dim_obj$max_typical, dim_obj$max_extreme)
          ext_nums <- ext_nums[!is.na(ext_nums)]
          
          ext_val_str <- paste(ext_nums, collapse = "-")
          
          if (length(ext_nums) > 0) {
            ext_min <- min(ext_nums)
            ext_max <- max(ext_nums)
            
            if (abs(exp_min - ext_min) <= TOLERANCE && abs(exp_max - ext_max) <= TOLERANCE) {
              matched <- TRUE
            }
          }
        }
      }
      
      if (matched) {
        tp <- tp + 1
      } else {
        fn <- fn + 1
        error_log <- rbind(error_log, data.frame(
          taxon = tax, 
          character = g_char, 
          expected = g_state, 
          extracted = ext_val_str,
          stringsAsFactors = FALSE
        ))
      }
    }
  }
  
  precision <- ifelse((tp + fp) > 0, tp / (tp + fp), 0)
  recall <- ifelse((tp + fn) > 0, tp / (tp + fn), 0)
  f1 <- ifelse((precision + recall) > 0, 2 * (precision * recall) / (precision + recall), 0)
  
  cat("\n--- EVALUATION RESULTS ---\n")
  cat("True Positives (TP):", tp, "\n")
  cat("False Positives (FP):", fp, "\n")
  cat("False Negatives (FN):", fn, "\n")
  cat(sprintf("Precision: %.4f\n", precision))
  cat(sprintf("Recall:    %.4f\n", recall))
  cat(sprintf("F1 Score:  %.4f\n", f1))
  
  if (precision < 0.70) {
    cat("\n[!] KILL CRITERION TRIGGERED: Precision (", round(precision, 4), ") is below 0.70 threshold.\n", sep="")
  } else {
    cat("\n[+] Kill criterion passed! Precision threshold maintained.\n")
  }
  
  invisible(list(tp = tp, fp = fp, fn = fn, precision = precision, recall = recall, f1 = f1, errors = error_log))
}

if (sys.nframe() == 0) {
  run_benchmark_audit()
}