# Test script for Phase 2 name resolution
source('R/resolve_names.R')

# Sample raw taxonomic names with extra whitespace
sample_names <- c(
  "Abies pindrow ",
  " Cedrus deodara",
  "Pinus wallichiana   "
)

message("Running name resolution test...")
resolved_result <- ta_resolve_names(sample_names)
print(resolved_result)
message("Phase 2 resolver test executed successfully!")
