get_bootstraped_season_parameter_distribution <- function(raw_egg_data, B) {
  long_data <- set_bootstrap_eggs_data(raw_egg_data)
  comprehenr::to_vec(for (i in 1:B) XXget_Temporada_coef(dplyr::sample_frac(long_data, replace = TRUE)))
}

set_bootstrap_eggs_data <- function(raw_egg_data) {
  raw_egg_data |>
    dplyr::rowwise() |>
    dplyr::mutate(
      is_chick_fledged = list(c(rep(1, Number_of_chicks_fledged), rep(0, No_eggs - Number_of_chicks_fledged)))
    ) |>
    tidyr::unnest(is_chick_fledged) |>
    dplyr::select(Temporada, No_eggs, Number_of_chicks_fledged, is_chick_fledged)
}
