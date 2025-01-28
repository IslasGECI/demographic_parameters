describe("set egg data for bootstrapping", {
  raw_egg_data <- readr::read_csv("/workdir/tests/data/breeding_success_for_tests.csv")
  obtained <- set_bootstrap_eggs_data(raw_egg_data)
  it("should return a tibble with number of rows equal to the total laided egss", {
    exected_len <- sum(raw_egg_data$No_eggs)
    expect_equal(nrow(obtained), exected_len)
  })
  it("should return a tibble with number of a binary column if chicks fledged", {
    expected_chicks_fledged <- sum(raw_egg_data$Number_of_chicks_fledged)
    obtained_chicks_fledged <- sum(obtained$is_chick_fledged)
    expect_equal(obtained_chicks_fledged, expected_chicks_fledged)
  })
  it("remove unused columns", {
    expected_columns <- c("Temporada", "No_eggs", "Number_of_chicks_fledged", "is_chick_fledged")
    obtained_columns <- colnames(obtained)
    expect_true(all(obtained_columns %in% expected_columns))
  })
})

describe("Calculate breeding success", {
  it("Rows are equal to long table", {
    long_egg_data <- tibble::tibble(
      Temporada = c(2016, 2016, 2017, 2017, 2018, 2018, 2018),
      No_eggs = c(2, 2, 2, 2, 3, 3, 3),
      Number_of_chicks_fledged = c(2, 2, 0, 0, 2, 2, 2),
      is_chick_fledged = c(1, 1, 0, 0, 1, 1, 0)
    )
    obtained <- calculate_breeding_success(long_egg_data)
    expected <- nrow(long_egg_data)
    expect_equal(nrow(obtained), expected)
  })
})
