# End-to-end integration test for the taxaudit package
source('R/ingest_fetch.R')
source('R/ingest_parse.R')
source('R/resolve_names.R')
source('R/metrics_diagnosability.R')
source('R/run_audit.R')

# Test URL from Flora of Pakistan
sample_url <- 'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124089'

message('--- STARTING TAXONOMIC AUDIT PIPELINE ---')
audit_result <- ta_run_audit(sample_url)

message('--- FINAL AUDIT REPORT ---')
print(audit_result)
message('Pipeline test completed successfully!')
