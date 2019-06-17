#!/usr/bin/env nextflow
params.name             = "RNA-seq"
params.reads            = "/data/fastq/*{*_R1,*_R2}.fastq.gz"


log.info "RNA-seq Pipeline"
log.info "====================================="
log.info "name         : ${params.name}"
log.info "reads        : ${params.reads}"
log.info "\n"


reads = Channel.fromFilePairs(params.reads, size: -1)
