get_bootstraped_logistic_growth_rate_distribution <- function(raw_egg_data, B) {
  long_data <- set_bootstrap_eggs_data(raw_egg_data)
  set.seed(42)
  distributor <- Distributor$new(long_data)
  resampled_data <- comprehenr::to_list(for (i in 1:B) distributor$sample())
  comprehenr::to_vec(for (sample in resampled_data) get_Temporada_coef(sample))
}

set_bootstrap_eggs_data <- function(raw_egg_data) {
  raw_egg_data |>
    dplyr::rowwise() |>
    .add_chick_status() |>
    dplyr::select(Temporada, No_eggs, Number_of_chicks_fledged, is_chick_fledged)
}

fetch_json_content <- function(raw_egg_data, parameter_distribution, alpha) {
  p_values <- .get_json_of_p_value(parameter_distribution)
  parameter_distribution_string <- .get_json_of_value(parameter_distribution)
  raw_egg_data_list <- .get_json_of_value(raw_egg_data)
  interval <- .get_json_of_interval(parameter_distribution, alpha)
  latex_interval <- .get_json_of_latex_interval(parameter_distribution, alpha)
  paste0('{"raw_data":', raw_egg_data_list, ',"bootstrap_distribution":', parameter_distribution_string, ',"alpha":', alpha, ',"bootstrap_interval":', interval, ',"bootstrap_interval_latex":', latex_interval, ',"p_values":', p_values, "}")
}

.get_json_of_p_value <- function(parameter_distribution) {
  p_values <- calculate_p_values(parameter_distribution)
  .get_json_of_value(p_values)
}

.get_json_of_interval <- function(parameter_distribution, alpha) {
  interval <- get_bootstrap_interval(parameter_distribution, alpha)
  .get_json_of_value(interval)
}

.get_json_of_value <- function(value) {
  value |>
    rjson::toJSON()
}
.get_json_of_latex_interval <- function(parameter_distribution, alpha) {
  get_bootstrap_interval(parameter_distribution, alpha) |>
    get_bootstrap_interval_latex() |>
    rjson::toJSON()
}

get_bootstrap_interval_latex <- function(interval) {
  glue::glue("{interval[2]} ({interval[1]} --- {interval[3]})")
}

get_bootstrap_interval <- function(bootstrap_distribution, alpha) {
  quantiles <- quantile(bootstrap_distribution, c(alpha / 2, 0.5, 1 - alpha / 2)) |> unname()
  return(quantiles)
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
    data = NULL,
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
calculate_p_values <- function(season_parameter_distribution) {
  distribution_length <- length(season_parameter_distribution)
  number_of_negatives <- sum(season_parameter_distribution < 0)
  number_of_positives <- sum(season_parameter_distribution > 0)
  list("p_value_decreasing" = number_of_negatives / distribution_length, "p_value_increasing" = number_of_positives / distribution_length)
}
