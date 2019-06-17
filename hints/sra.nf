#!/usr/bin/env nextflow
params.name             = "RNA-seq"
params.email            = "michael.smallegan@colorado.edu"


log.info "SRA retrieve pipeline"
log.info "====================================="
log.info "name         : ${params.name}"
log.info "email        : ${params.email}"
log.info "\n"

Channel
    .fromSRA('SRP043510')
    .set{reads}

process fastqc {
    input:
    set sample_id, file(reads_file) from reads

    output:
    file("fastqc_${sample_id}_logs") into fastqc_ch

    script:
    """
    mkdir fastqc_${sample_id}_logs
    fastqc -o fastqc_${sample_id}_logs -f fastq -q ${reads_file}
    """
}
