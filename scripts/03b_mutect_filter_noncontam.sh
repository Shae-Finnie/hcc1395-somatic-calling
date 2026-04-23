#!/bin/bash

set -euo pipefail

# Less conservative mutect filter that doesn't use contamination tables 

echo " Running mutect filter without contamination tables "

gatk FilterMutectCalls \
  -R data/refs/Homo_sapiens_assembly38.fasta \
  -V results/mutect2/somatic.vcf.gz \
  --stats results/mutect2/somatic.vcf.gz.stats \
  -O results/mutect2/somatic.filtered.nocontam.vcf.gz 

echo " Mutect filtering complete, vcf saved to results/mutect2/somatic.filtered.nocontam.vcf.gz "