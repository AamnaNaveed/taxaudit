test_that('pairwise DI calculates correctly between species', {
  chars1 <- list(leaf_shape = 'elliptic', leaf_margin = 'entire')
  chars2 <- list(leaf_shape = 'lanceolate', leaf_margin = 'entire')
  res <- ta_pairwise_di(chars1, chars2)
  expect_true(res$is_diagnosable)
  expect_equal(res$di_score, 0.5)
})
