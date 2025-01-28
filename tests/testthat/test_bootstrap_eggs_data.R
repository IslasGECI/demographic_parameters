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
})
