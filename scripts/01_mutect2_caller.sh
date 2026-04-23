#!/bin/bash

set -euo pipefail

# Initial Mutect2 run

echo " ********************* "
echo "    Running Mutect2    "
echo " ********************* "

gatk Mutect2 \
  --native-pair-hmm-threads 8 \
  -R data/refs/Homo_sapiens_assembly38.fasta \
  -I data/raw/WES_IL_T_1.bwa.dedup.bam \
  -I data/raw/WES_IL_N_1.bwa.dedup.bam \
  -normal WES_IL_N_1 \
  --germline-resource data/resources/af-only-gnomad.hg38.vcf.gz \
  -L data/resources/wgs_calling_regions.hg38.interval_list \
  -O results/mutect2/somatic.vcf.gz

echo " ********************* "
echo " Mutect2 call complete, vcf in /results/mutect2 "
echo " ********************* "

  # Mutect2 scans the tumor and normal BAMs side by side, calling positions where the tumor carries 
  # variant alleles that are absent in the matched normal and not common in the gnomAD population reference.
  # The output is a raw VCF of candidate somatic mutations, which still needs filtering 
  # with FilterMutectCalls before it is usable.