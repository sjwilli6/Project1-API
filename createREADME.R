# author: Spencer Williams
# date: 06/25/2023
# purpose: Render Project1-API.Rmd as a .md file called README.md for my repo.

rmarkdown::render(
  input="Project1-API.Rmd",
  output_format = "github_document",
  output_file = "README.md",
  runtime = "static",
  clean = TRUE,
  params = NULL,
  knit_meta = NULL,
  envir = parent.frame(),
  run_pandoc = TRUE,
  quiet = FALSE,
  encoding = "UTF-8"
)