set_bootstrap_eggs_data <- function(raw_egg_data) {
  raw_egg_data |>
    dplyr::rowwise() |>
    dplyr::mutate(egg_id = list(rep(1, No_eggs))) |>
    tidyr::unnest(egg_id) |>
    dplyr::select(-egg_id)
}
