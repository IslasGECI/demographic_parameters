fit_breeding_success <- function(data) {
  glm(breeding_success ~ Temporada, data = data, family = binomial)
}
