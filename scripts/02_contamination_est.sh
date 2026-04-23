#!/bin/bash
set -euo pipefail

## Run Pileups in parallel on seperate terminals to speed things up

# Pileup summaries for tumor
gatk GetPileupSummaries \
  -I data/raw/WES_IL_T_1.bwa.dedup.bam \
  -V data/resources/af-only-gnomad.hg38.vcf.gz \
  -L data/resources/wgs_calling_regions.hg38.interval_list \
  -O results/contamination/tumor_pileups.table

# Pileup summaries for normal
gatk GetPileupSummaries \
  -I data/raw/WES_IL_N_1.bwa.dedup.bam \
  -V data/resources/af-only-gnomad.hg38.vcf.gz \
  -L data/resources/wgs_calling_regions.hg38.interval_list \
  -O results/contamination/normal_pileups.table

# Calculate contamination using matched normal
gatk CalculateContamination \
  -I results/contamination/tumor_pileups.table \
  -matched results/contamination/normal_pileups.table \
  -O results/contamination/contamination.table \
  --tumor-segmentation results/contamination/segments.table