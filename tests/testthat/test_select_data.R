describe("Select data", {
  raw_data <- readr::read_csv("/workdir/tests/data/censo_aves_superficie_todas_islas_2018.csv", show_col_types = FALSE)
  it("select columns", {
    obtained <- select_data(raw_data)
    obtained_columns <- colnames(obtained)
    expected_columns <- c("Fecha", "Hora", "Isla", "Especie", "Nombre_o_ID_del_sitio_o_colonia", "ID_del_nido_o_madriguera", "ID_del_anillo", "Cantidad_nidos", "Cantidad_huevos", "Cantidad_pollos_volanton")
    expect_equal(obtained_columns, expected_columns)
  })
})
