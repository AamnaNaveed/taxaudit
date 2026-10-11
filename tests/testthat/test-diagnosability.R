
test_that("Diagnosability Index handles controls, partial overlap, NAs, and numeric ranges", {
  # 1. Identical and Disjoint controls
  expect_equal(calculate_DI(c("A", "B", "C"), c("A", "B", "C")), 0)
  expect_equal(calculate_DI(c("A", "B", "C"), c("X", "Y", "Z")), 1)
  
  # 2. Partial overlap: 2 of 5 characters differ -> DI = 0.4
  t1 <- c("A", "B", "C", "D", "E")
  t2 <- c("A", "B", "X", "Y", "E")
  expect_equal(calculate_DI(t1, t2), 0.4)
  
  # 3. Missing values: NA must never count as a contrast
  t3 <- c("A", "B", NA, "D")
  t4 <- c("A", "B", "C", NA)
  # Valid positions are index 1 and 2 (both match -> DI = 0)
  expect_equal(calculate_DI(t3, t4), 0.0)
  
  # 4. Numeric range gap: ranges 2 to 5 and 8 to 12 should contrast
  expect_equal(calculate_DI("2-5", "8-12"), 1.0)
  expect_equal(calculate_DI("2-5", "3-6"), 0.0) # Overlapping ranges do not contrast
})

