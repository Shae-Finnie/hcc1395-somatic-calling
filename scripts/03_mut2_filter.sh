#!/bin/bash
set -euo pipefail

gatk FilterMutectCalls \
  -R data/refs/Homo_sapiens_assembly38.fasta \
  -V results/mutect2/somatic.vcf.gz \
  --stats results/mutect2/somatic.vcf.gz.stats \
  -O results/mutect2/somatic.filtered.vcf.gz