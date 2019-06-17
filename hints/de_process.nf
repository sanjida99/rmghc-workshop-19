process differential_expression {

  publishDir "reports"

  input:
  file annotation from annotation_for_de
  file salmon from salmon_for_de.collect()
  file sample_info from sample_info

  output:
  file "*.html"

  script:
  """
  cp ${baseDir}/bin/*.R* .
  Rscript -e 'rmarkdown::render("differential_expression.Rmd", params = list(annotation_file = "${annotation}"))'
  """
}
