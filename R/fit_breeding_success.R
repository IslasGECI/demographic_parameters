fit_breeding_success <- function(data) {
  glm(is_chick_fledged ~ Temporada, data = data, family = binomial)
}
get_Temporada_coef <- function(data) {
  model <- fit_breeding_success(data)
  coef(model)["Temporada"]
}
