write_breeding_success_trend <- function(options) {
  raw_egg_data <- readr::read_csv(options[["data-path"]], show_col_types = FALSE)
  obtained <- get_bootstraped_season_parameter_distribution(raw_egg_data, B = options[["B"]]) |>
    rjson::toJSON()
  raw_egg_data_list <- raw_egg_data |>
    rjson::toJSON()
  p_values <- calculate_p_values(obtained) |>
    rjson::toJSON()
  distribution <- paste0('{"raw_data":', raw_egg_data_list, ',"bootstrap_distribution":', obtained, ',"p_values":', p_values, "}")
  distribution |>
    write(options[["output-path"]])
}
