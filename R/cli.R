write_breeding_success_trend <- function(options) {
  list(B = options[["B"]]) |>
    rjson::toJSON() |>
    write(options[["output-path"]])
}
