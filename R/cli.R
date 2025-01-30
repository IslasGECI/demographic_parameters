write_breeding_success_trend <- function(options) {
  raw_egg_data <- readr::read_csv(options[["data-path"]], show_col_types = FALSE)
  parameter_distribution <- get_bootstraped_season_parameter_distribution(raw_egg_data, B = options[["B"]])
  alpha <- 0.05
  json_content <- fetch_json_content(raw_egg_data, parameter_distribution, alpha)
  json_content |>
    write(options[["output-path"]])
}
