test_that('ontology extraction finds correct character states', {
  text <- 'Leaves elliptic, margins entire, indumentum glabrous, flowers yellow.'
  chars <- ta_extract_characters(text)
  expect_equal(chars$leaf_shape, 'elliptic')
  expect_equal(chars$leaf_margin, 'entire')
  expect_equal(chars$indumentum, 'glabrous')
  expect_equal(chars$flower_color, 'yellow')
})
