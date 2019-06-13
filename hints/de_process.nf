process differential_expression {

  publishDir 'reports', mode: 'copy'

  input:
  file sample_file from salmon_for_de.collect()
  file annotation from annotation_for_de
  file sample_info from sample_info

  output:
  file "*.html"

  script:
  """
  cp ${baseDir}/bin/differential_expression.Rmd .
  cp ${baseDir}/bin/*.R .
  Rscript -e 'rmarkdown::render("differential_expression.Rmd", \
    params = list(baseDir = "${baseDir}",\
                  annotation_file = "${annotation}"))'
  """
}
