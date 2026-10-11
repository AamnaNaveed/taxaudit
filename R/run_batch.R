#' Run taxonomic audit across multiple treatment URLs
#' 
#' @param urls Character vector of treatment URLs.
#' @return A combined data frame containing audit results for all successfully processed taxa.
#' @export
ta_run_batch_audit <- function(urls) {
  results_list <- list()
  
  for (i in seq_along(urls)) {
    url <- urls[i]
    message(sprintf("Processing [%d/%d]: %s", i, length(urls), url))
    
    # Wrap in tryCatch so a single failed page doesn't crash the batch
    res <- tryCatch({
      ta_run_audit(url)
    }, error = function(e) {
      message(sprintf("Error auditing %s: %s", url, e$message))
      NULL
    })
    
    if (!is.null(res)) {
      results_list[[length(results_list) + 1]] <- res
    }
  }
  
  if (length(results_list) > 0) {
    return(do.call(rbind, results_list))
  } else {
    return(data.frame())
  }
}
