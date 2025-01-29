write_breeding_success_trend <- function(options) {
  raw_egg_data <- readr::read_csv(options[["data-path"]], show_col_types = FALSE)
  obtained <- get_bootstraped_season_parameter_distribution(raw_egg_data, B = options[["B"]])
  distribution <- list("bootstrap_distribution" = obtained)
  distribution |>
    rjson::toJSON() |>
    write(options[["output-path"]])
}
