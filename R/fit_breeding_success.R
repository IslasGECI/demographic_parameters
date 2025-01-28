fit_breeding_success <- function(data) {
  glm(is_chick_fledged ~ Temporada, data = data, family = binomial)
}
get_Temporada_coef <- function(model) {
  coef(model)["Temporada"]
}
