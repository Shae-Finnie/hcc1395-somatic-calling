#!/bin/bash

# Project Reference Downloader

set -euo pipefail

# Dir routing
REF_DIR="data/refs"
RES_DIR="data/resources"

# Hg38 downloads
echo "**************************"
echo "downloading hg38 ref files"
echo "**************************"
wget -P "$REF_DIR" https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta
wget -P "$REF_DIR" https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.fasta.fai
wget -P "$REF_DIR" https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/Homo_sapiens_assembly38.dict
echo "**************************"
echo "hg38 ref files downloaded to data/refs"
echo "**************************"

# gnomAD downloads for Mutect
echo "**************************"
echo "downloading gnmoAD common human germline variants ref"
echo "**************************"
wget -P "$RES_DIR" https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/somatic-hg38/af-only-gnomad.hg38.vcf.gz
wget -P "$RES_DIR" https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/somatic-hg38/af-only-gnomad.hg38.vcf.gz.tbi
wget -P "$RES_DIR" https://storage.googleapis.com/gcp-public-data--broad-references/hg38/v0/wgs_calling_regions.hg38.interval_list
echo "**************************"
echo "gnmoAD refs downloaded to data/resources"
echo "**************************"
