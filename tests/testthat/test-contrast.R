test_that('author mode contrast table builds correctly', {
  t1 <- 'Leaves elliptic, margins entire.'
  t2 <- 'Leaves lanceolate, margins serrate.'
  df <- ta_contrast_table(t1, t2, 'Species A', 'Species B')
  expect_true('Character_Category' %in% names(df))
  expect_true('Taxon_1' %in% names(df))
  expect_true('Taxon_2' %in% names(df))
  expect_true('Status' %in% names(df))
})
