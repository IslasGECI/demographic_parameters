select_data <- function(raw_data) {
  obtained <- raw_data |> dplyr::select(c("Fecha", "Hora", "Isla", "Especie", "Nombre_o_ID_del_sitio_o_colonia", "ID_del_nido_o_madriguera", "ID_del_anillo", "Cantidad_nidos", "Cantidad_huevos", "Cantidad_pollos_volanton"))
  return(obtained)
}
