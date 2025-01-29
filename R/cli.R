write_breeding_success_trend <- function(options) {
  raw_egg_data <- readr::read_csv(options[["data-path"]], show_col_types = FALSE)
  parameter_distribution <- get_bootstraped_season_parameter_distribution(raw_egg_data, B = options[["B"]])
  p_values <- calculate_p_values(parameter_distribution) |>
    rjson::toJSON()
  parameter_distribution_string <- parameter_distribution |>
    rjson::toJSON()
  raw_egg_data_list <- raw_egg_data |>
    rjson::toJSON()
  json_content <- paste0('{"raw_data":', raw_egg_data_list, ',"bootstrap_distribution":', parameter_distribution_string, ',"p_values":', p_values, "}")
  json_content |>
    write(options[["output-path"]])
}

fetch_json_content <- function(raw_egg_data, parameter_distribution) {
  p_values <- calculate_p_values(parameter_distribution) |>
    rjson::toJSON()
  parameter_distribution_string <- parameter_distribution |>
    rjson::toJSON()
  raw_egg_data_list <- raw_egg_data |>
    rjson::toJSON()
  paste0('{"raw_data":', raw_egg_data_list, ',"bootstrap_distribution":', parameter_distribution_string, ',"p_values":', p_values, "}")
}
