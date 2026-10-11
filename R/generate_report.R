#' Generate Automated Taxonomic Audit Report
#'
#' @description Generates automated taxonomic ambiguity reports for floristic datasets.
#' @importFrom utils combn write.csv
#' @import ggplot2
#' @import furrr
#' @import future
#' @param flora_list Named list of taxon descriptions.
#' @param output_dir Directory path to save output reports and data.
#' @return Invisibly returns a list containing audit summary statistics and results.
#' @export

ta_generate_report <- function(flora_list, output_dir = 'inst/output') {
  if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
  
  message('Step 1: Running parallel character extraction...')
  if (requireNamespace('furrr', quietly = TRUE) && future::nbrOfWorkers() > 1) {
    char_cache <- furrr::future_map(flora_list, ta_extract_characters, .options = furrr::furrr_options(seed = TRUE))
  } else {
    char_cache <- lapply(flora_list, ta_extract_characters)
  }
  
  message('Step 2: Computing pairwise diagnosability matrix...')
  s_names <- names(flora_list)
  combs <- combn(s_names, 2)
  
  pairs_df <- data.frame(
    Taxon_1 = combs[1, ],
    Taxon_2 = combs[2, ],
    stringsAsFactors = FALSE
  )
  
  # Compute DI scores
  results_list <- lapply(1:nrow(pairs_df), function(i) {
    t1 <- pairs_df$Taxon_1[i]
    t2 <- pairs_df$Taxon_2[i]
    res <- ta_pairwise_di(char_cache[[t1]], char_cache[[t2]])
    data.frame(
      Taxon_1 = t1,
      Taxon_2 = t2,
      DI_Score = res$di_score,
      Is_Diagnosable = res$is_diagnosable,
      stringsAsFactors = FALSE
    )
  })
  
  batch_results <- do.call(rbind, results_list)
  
  # Save raw outputs
  csv_path <- file.path(output_dir, 'taxaudit_report_summary.csv')
  write.csv(batch_results, csv_path, row.names = FALSE)
  
  # Generate and save heatmap
  p <- ta_plot_heatmap(batch_results)
  plot_path <- file.path(output_dir, 'taxaudit_heatmap.png')
  ggplot2::ggsave(plot_path, plot = p, width = 7, height = 6, dpi = 300)
  
  # Compile summary stats
  summary_stats <- list(
    total_taxa = length(flora_list),
    total_pairs = nrow(batch_results),
    mean_di = mean(batch_results$DI_Score),
    ambiguous_pairs = batch_results[batch_results$DI_Score == 0, ]
  )
  
  message(sprintf('taxaudit complete! Evaluated %d taxa (%d pairs). Saved reports to %s',
                  summary_stats$total_taxa, summary_stats$total_pairs, output_dir))
  
  invisible(list(summary = summary_stats, data = batch_results))
}

