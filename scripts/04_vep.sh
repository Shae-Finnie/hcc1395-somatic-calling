#!/bin/bash
set -euo pipefail

# env: vep
# usage: run from project root 

mkdir -p results/annotated

# Extract PASS-only variants from both VCFs
bcftools view -f PASS results/mutect2/somatic.filtered.vcf.gz \
  -Oz -o results/annotated/somatic.strict.pass.vcf.gz
bcftools index -t results/annotated/somatic.strict.pass.vcf.gz

bcftools view -f PASS results/mutect2/somatic.filtered.nocontam.vcf.gz \
  -Oz -o results/annotated/somatic.nocontam.pass.vcf.gz
bcftools index -t results/annotated/somatic.nocontam.pass.vcf.gz

# Common VEP args
VEP_ARGS="--cache --offline --merged --assembly GRCh38 --species homo_sapiens \
  --fork 4 --vcf --symbol --canonical --protein --biotype \
  --fasta data/refs/Homo_sapiens_assembly38.fasta"

# Annotate strict version
vep \
  --input_file results/annotated/somatic.strict.pass.vcf.gz \
  --output_file results/annotated/somatic.strict.vep.vcf \
  --stats_file results/annotated/vep_stats_strict.html \
  $VEP_ARGS

# Annotate nocontam version
vep \
  --input_file results/annotated/somatic.nocontam.pass.vcf.gz \
  --output_file results/annotated/somatic.nocontam.vep.vcf \
  --stats_file results/annotated/vep_stats_nocontam.html \
  $VEP_ARGS