test_that("ta_load_corpus loads correctly", {
  corpus <- ta_load_corpus()
  expect_s3_class(corpus, "data.frame")
  expect_true(nrow(corpus) > 0)
  expect_true("text" %in% names(corpus))
  expect_true("taxon" %in% names(corpus))
})

test_that("ta_extract_traits extracts valid spans and ontology terms", {
  sample_text <- "The species is a large tree. Leaves 5.5-10.2 cm long, lanceolate."
  traits <- ta_extract_traits(sample_text)
  expect_s3_class(traits, "data.frame")
  if (nrow(traits) > 0) {
    expect_true("ontology_id" %in% names(traits))
    expect_equal(traits$ontology_id[1], "PO:0025034")
  }
})

test_that("ta_baseline_extract and ta_compare_baseline work", {
  corpus <- ta_load_corpus()
  baseline_res <- ta_baseline_extract(corpus$text[1])
  expect_s3_class(baseline_res, "data.frame")
  
  comp <- ta_compare_baseline(corpus)
  expect_s3_class(comp, "data.frame")
  expect_true("baseline_yield" %in% names(comp))
  expect_true("advanced_ontology_yield" %in% names(comp))
})

test_that("ta_split_evaluation functions properly", {
  corpus <- ta_load_corpus()
  splits <- ta_split_evaluation(corpus, target_holdout = corpus$taxon[1])
  expect_type(splits, "list")
})
