describe("`fit_breeding_success()`", {
  long_egg_data <- tibble::tibble(
    Temporada = c(2016, 2016, 2017, 2017, 2018, 2018, 2018),
    breeding_success = c(1, 1, 0, 0, 0.33, 0.33, 0.33)
  )
  it("fit breeding success using binomial family", {
    model <- fit_breeding_success(data = long_egg_data)
    coef_values <- coef(model)
  })
})
