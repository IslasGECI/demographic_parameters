describe("`fit_breeding_success()`", {
  long_egg_data <- tibble::tibble(
    Temporada = c(2016, 2016, 2017, 2017, 2018, 2018, 2018),
    is_chick_fledged = c(1, 0, 0, 0, 1, 1, 1)
  )
  it("get Temporada coefficient", {
    Temporada_coef <- get_Temporada_coef(long_egg_data)
    expect_true(Temporada_coef > 0)
  })
})
