get_bootstraped_season_parameter_distribution <- function(raw_egg_data, B) {
  long_data <- set_bootstrap_eggs_data(raw_egg_data)
  resampled_data <- comprehenr::to_list(for (i in 1:B) dplyr::sample_frac(long_data, replace = TRUE))
  comprehenr::to_vec(for (sample in resampled_data) get_Temporada_coef(sample))
}

set_bootstrap_eggs_data <- function(raw_egg_data) {
  raw_egg_data |>
    dplyr::rowwise() |>
    .add_chick_status() |>
    dplyr::select(Temporada, No_eggs, Number_of_chicks_fledged, is_chick_fledged)
}

.add_chick_status <- function(rowwise_egg_data) {
  rowwise_egg_data |>
    dplyr::mutate(
      is_chick_fledged = list(c(rep(1, Number_of_chicks_fledged), rep(0, No_eggs - Number_of_chicks_fledged)))
    ) |>
    tidyr::unnest(is_chick_fledged)
}

Distributor <- R6::R6Class("Distribution",
  public = list(
    initialize = function(data) {
      self$data <- data
    },
    raw = function() {
      return(self$data)
    },
    sample = function() {
      dplyr::sample_frac(self$data, replace = TRUE)
    }
  )
)
