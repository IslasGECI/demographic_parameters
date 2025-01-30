raw_egg_data <- readr::read_csv("/workdir/tests/data/breeding_success_for_tests.csv", show_col_types = FALSE)

describe("Write JSON content", {
  it("Return a string", {
    B <- 50
    parameter_distribution <- get_bootstraped_season_parameter_distribution(raw_egg_data, B = B)
    alpha <- 0.05
    obtained <- fetch_json_content(raw_egg_data, parameter_distribution, alpha)
    expect_true(is.character(obtained))
    expect_true(stringr::str_detect(obtained, '"p_value_decreasing":1', negate = TRUE))
    expected_alpha <- paste0('"alpha":', alpha)
    expect_true(stringr::str_detect(obtained, expected_alpha))
    expected_fields <- c("raw_data", "bootstrap_distribution", "bootstrap_interval", "bootstrap_interval_latex", "p_values", "alpha")
    expect_true(all(stringr::str_detect(obtained, expected_fields)))
    # expect_true(stringr::str_detect(obtained, '"bootstrap_interval_latex":,', negate = TRUE))
  })
})

describe("Give bootstrap interval", {
  it("Get interval from distribution", {
    bootstrap_distribution <- c(0:100)
    alpha <- 0.1
    obtained <- get_bootstrap_interval(bootstrap_distribution, alpha)
    expect_equal(obtained, c(5, 50, 95))

    alpha <- 0.06
    obtained <- get_bootstrap_interval(bootstrap_distribution, alpha)
    expect_equal(obtained, c(3, 50, 97))
  })
  it("Get interval in string", {
    interval <- c(3, 50, 97)
    obtained <- get_bootstrap_interval_latex(interval)
    expected <- "50 (3 — 97)"
    expect_equal(obtained, expected)
  })
})

describe("get bootstraped season parameter", {
  it("should return a positive value", {
    B <- 10
    obtained <- get_bootstraped_season_parameter_distribution(raw_egg_data, B = B)
    expect_equal(length(obtained), B)
    expected_first_value <- -0.8856786
    expected_last_value <- -0.2470413
    expect_equal(obtained[[1]], expected_first_value, tolerance = 1e-6)
    expect_equal(obtained[[B]], expected_last_value, tolerance = 1e-6)
  })
})

describe("Calculate p-value from distribution", {
  it("Calculate basic probability", {
    season_parameter_distribution <- c(-0.1, -0.2, -0.3, -0.4, -0.5, -0.6, -0.7, -0.8, -0.9, -0.98, 0.7)
    obtained <- calculate_p_values(season_parameter_distribution)
    p_value_decreasing <- 10 / 11
    p_value_increasing <- 1 / 11
    expected <- list("p_value_decreasing" = p_value_decreasing, "p_value_increasing" = p_value_increasing)
    expect_equal(obtained, expected)
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
