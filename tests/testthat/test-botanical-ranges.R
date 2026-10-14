library(testthat)
source("../../R/extractor.R")

test_that("parse_botanical_range correctly handles complex parenthetical bounds", {
  res1 <- parse_botanical_range("(1.5-)2-4(-5.5) cm")
  expect_equal(res1$min_extreme, 1.5)
  expect_equal(res1$min_typical, 2.0)
  expect_equal(res1$max_typical, 4.0)
  expect_equal(res1$max_extreme, 5.5)
  expect_equal(res1$unit, "cm")
})

test_that("extract_real_traits processes real Cedrus deodara treatment", {
  txt <- extract_description("Cedrus deodara")
  traits <- extract_real_traits(txt)
  
  expect_equal(traits$growth_form, "tree")
  expect_equal(traits$leaf_dimensions$min_extreme, 2.5)
  expect_equal(traits$leaf_dimensions$min_typical, 3.0)
  expect_equal(traits$leaf_dimensions$max_typical, 4.5)
  expect_equal(traits$leaf_dimensions$unit, "cm")
  expect_equal(traits$reproductive_size$min_typical, 7.0)
  expect_equal(traits$reproductive_size$max_typical, 12.0)
})

test_that("extract_real_traits processes real Quercus incana treatment with complex leaves", {
  txt <- extract_description("Quercus incana")
  traits <- extract_real_traits(txt)
  
  expect_equal(traits$growth_form, "tree")
  expect_equal(traits$leaf_dimensions$min_extreme, 6.0)
  expect_equal(traits$leaf_dimensions$max_typical, 15.0)
  expect_equal(traits$leaf_dimensions$unit, "cm")
})
