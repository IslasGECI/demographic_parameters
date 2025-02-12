describe("Test cli for breeding success trend", {
  it("Test cli", {
    data_path <- "/workdir/tests/data/breeding_success_for_tests.csv"
    bootstrap_number <- 10
    output_path <- "/workdir/tests/data/breeding_success_trend.json"
    options <- list("data-path" = data_path, "B" = bootstrap_number, "output-path" = output_path)
    testtools::if_exist_remove(output_path)
    write_breeding_success_trend(options)

    expect_true(testtools::exist_output_file(output_path))
  })
})
