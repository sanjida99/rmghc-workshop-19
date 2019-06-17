#!/usr/bin/env nextflow
params.name             = "RNA-seq"
params.reads            = "/data/fastq/*{*_R1,*_R2}.fastq.gz"
params.email            = "michael.smallegan@colorado.edu"


log.info "RNA-seq Pipeline"
log.info "====================================="
log.info "name         : ${params.name}"
log.info "reads        : ${params.reads}"
log.info "email        : ${params.email}"
log.info "\n"


reads = Channel.fromFilePairs(params.reads, size: -1)

process view_reads {

  publishDir "results"

  input:
  set sample_id, file(read_files) from reads

  output:
  file "first_reads.txt"

  script:
  """
  zcat ${read_files[[1]]} | head > first_reads.txt
  """
}
