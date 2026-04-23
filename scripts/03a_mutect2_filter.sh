#!/bin/bash

set -euo pipefail

echo " Running mutect filter "

gatk FilterMutectCalls \
  -R data/refs/Homo_sapiens_assembly38.fasta \
  -V results/mutect2/somatic.vcf.gz \
  --stats results/mutect2/somatic.vcf.gz.stats \
  --contamination-table results/contamination/contamination.table \
  --tumor-segmentation results/contamination/segments.table \
  -O results/mutect2/somatic.filtered.vcf.gz

  echo " Mutect filtering complete, vcf saved to results/mutect2/ "