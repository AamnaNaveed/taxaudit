# Test script for Phase 1 ingestion pipeline
library(digest)
library(httr2)
library(xml2)
library(rvest)

# Source our custom functions
source('R/ingest_fetch.R')
source('R/ingest_parse.R')

# Sample test URL from Flora of Pakistan eFloras page
test_url <- 'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124089'

message('Testing fetcher...')
cached_file <- ta_fetch_treatment(test_url)
print(cached_file)

message('Testing parser...')
parsed_data <- ta_parse_treatment(cached_file)
print(parsed_data)
message('Phase 1 test script executed successfully!')
