# Comprehensive Test Suite for taxaudit package

message('=== TEST 1: Package Loading & Documentation Check ===')
library(taxaudit)
if (requireNamespace('taxaudit', quietly = TRUE)) {
  message('-> package loaded successfully.')
}

message('=== TEST 2: Single Treatment Audit Pipeline ===')
test_url <- 'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124089'
single_res <- ta_run_audit(test_url)
print(single_res)
stopifnot(nrow(single_res) == 1)
message('-> Single audit test PASSED.')

message('=== TEST 3: Multi-Taxon Batch Processing & CSV Export ===')
sample_urls <- c(
  'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124089',
  'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124090',
  'http://www.efloras.org/florataxon.aspx?flora_id=5&taxon_id=124091'
)
batch_res <- ta_run_batch_audit(sample_urls)
dir.create('output', showWarnings = FALSE)
report_path <- 'output/comprehensive_audit_report.csv'
write.csv(batch_res, report_path, row.names = FALSE)

if (file.exists(report_path)) {
  message(sprintf('-> Batch audit report successfully written to: %s', report_path))
} else {
  stop('Batch report file was not created!')
}
message('-> Batch audit test PASSED.')

message('ALL COMPREHENSIVE TAXAUDIT TESTS COMPLETED SUCCESSFULLY!')
