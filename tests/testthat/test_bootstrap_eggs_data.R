describe("set egg data for bootstrapping", {
  it("should return a tibble with number of rows equal to the total laided egss", {
    raw_egg_data <- readr::read_csv("/workdir/tests/data/breeding_success_for_tests.csv")
    obtained <- set_bootstrap_eggs_data(raw_egg_data)
    exected_len <- sum(raw_egg_data$No_eggs)
    expect_equal(nrow(obtained), exected_len)
  })
})
