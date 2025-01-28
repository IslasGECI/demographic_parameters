set_bootstrap_eggs_data <- function(raw_egg_data) {
  raw_egg_data |>
    dplyr::rowwise() |>
    dplyr::mutate(
      egg_id = list(rep(1, No_eggs)),
      is_chick_fledged = list(rep(1, Number_of_chicks_fledged) |>
        c(rep(0, No_eggs - Number_of_chicks_fledged)))
    ) |>
    tidyr::unnest(c(egg_id, is_chick_fledged)) |>
    dplyr::select(-egg_id)
}
