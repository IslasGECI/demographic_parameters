set_bootstrap_eggs_data <- function(raw_egg_data) {
  raw_egg_data |>
    dplyr::rowwise() |>
    dplyr::mutate(
      is_chick_fledged = list(c(rep(1, Number_of_chicks_fledged), rep(0, No_eggs - Number_of_chicks_fledged)))
    ) |>
    tidyr::unnest(is_chick_fledged) |>
    dplyr::select(Temporada, No_eggs, Number_of_chicks_fledged, is_chick_fledged)
}

calculate_breeding_success <- function(long_egg_data) {
  long_egg_data |>
    dplyr::group_by(Temporada) |>
    dplyr::mutate(
      breeding_success = sum(is_chick_fledged) / dplyr::n() + 0
    ) |>
    dplyr::ungroup()
}
