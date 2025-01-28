describe("`fit_breeding_success()`", {
  long_egg_data <- tibble::tibble(
    Temporada = c(2016, 2016, 2017, 2017, 2018, 2018, 2018),
    is_chick_fledged = c(1, 0, 0, 0, 1, 1, 1)
  )
  it("fit breeding success using binomial family", {
    model <- fit_breeding_success(data = long_egg_data)
    coef_values <- coef(model)
    predictions <- predict(model, type = "response")
  })
  it("get Temporada coefficient", {
    model <- fit_breeding_success(data = long_egg_data)
    Temporada_coef <- get_Temporada_coef(model)
    expect_true(Temporada_coef > 0)
  })
})
