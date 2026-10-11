# Test script for Phase 3 diagnosability metrics
source('R/ingest_parse.R')
source('R/metrics_diagnosability.R')

# Find a cached file from Phase 1 or use a dummy data frame for testing
cache_dir <- 'data-raw/cache'
cached_files <- list.files(cache_dir, full.names = TRUE)

if (length(cached_files) > 0) {
  message('Testing metrics on actual cached treatment...')
  parsed <- ta_parse_treatment(cached_files[1])
  scored <- ta_calculate_diagnosability(parsed)
  print(scored)
} else {
  message('No cache files found. Testing with dummy row...')
  dummy_df <- data.frame(file_path = 'dummy.html', extracted_text_length = 3500, parsed_at = as.character(Sys.time()))
  scored <- ta_calculate_diagnosability(dummy_df)
  print(scored)
}

message('Phase 3 metrics test script executed successfully!')
