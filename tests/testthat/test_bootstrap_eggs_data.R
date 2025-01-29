describe("get bootstraped season parameter", {
  it("should return a positive value", {
    B <- 10
    raw_egg_data <- readr::read_csv("/workdir/tests/data/breeding_success_for_tests.csv", show_col_types = FALSE)
    obtained <- get_bootstraped_season_parameter_distribution(raw_egg_data, B = B)
    expect_equal(length(obtained), B)
    expected_first_value <- -0.8856786
    expected_last_value <- -0.2470413
    expect_equal(obtained[[1]], expected_first_value)
    expect_equal(obtained[[B]], expected_last_value)
  })
})

describe("set egg data for bootstrapping", {
  raw_egg_data <- readr::read_csv("/workdir/tests/data/breeding_success_for_tests.csv", show_col_types = FALSE)
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
