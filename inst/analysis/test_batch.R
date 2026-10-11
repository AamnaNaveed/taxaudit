# End-to-end batch test for taxaudit package with CSV export
source('R/ingest_fetch.R')
source('R/ingest_parse.R')
source('R/resolve_names.R')
source('R/metrics_diagnosability.R')
source('R/run_audit.R')
source('R/run_batch.R')

# Multiple sample taxon URLs from Flora of Pakistan
sample_urls <- c(
  'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124089',
  'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124090',
  'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124091'
)

message('--- STARTING BATCH AUDIT RUN ---')
batch_results <- ta_run_batch_audit(sample_urls)

# Save results to CSV report
output_file <- 'output/batch_audit_report.csv'
write.csv(batch_results, output_file, row.names = FALSE)
message(sprintf('Batch audit report saved successfully to: %s', output_file))

message('--- MASTER BATCH AUDIT REPORT ---')
print(batch_results)
message('Batch test completed successfully!')
