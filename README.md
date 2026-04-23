# Paired-normal tumour sample variant calling using HCC1395 and HCC1395BL

This project implements a somatic variant calling pipeline using paired tumor and matched normal whole exome sequencing data from the HCC1395/HCC1395BL cell line pair. The data comes from the SEQC2 (Sequencing Quality Control Phase 2) Somatic Mutation Working Group, an FDA-led consortium that sequenced the same patient material at multiple centers to support cross-site reproducibility studies of somatic variant detection. Starting from pre-aligned BAMs, the pipeline runs GATK Mutect2 in tumor-versus-normal mode, applies standard filtering, and annotates variants using Ensembl VEP. Performance is benchmarked against the SEQC2 high-confidence truth set using bcftools isec, with precision and recall reported per variant class. The intent is to walk through a complete, reviewer-defensible somatic calling workflow on a dataset where the answers are already known.

### Directory Structure

```

├── data
│   ├── raw
│   ├── refs
│   └── resources
├── README.md
├── results
│   ├── contamination
│   └── mutect2
└── scripts
    ├── 00_ref_dl.sh
    ├── 01_mutect.sh
    ├── 02_contamination.sh
    ├── 03_mut2_filter.sh
    └── helpers.md

```

### Original Patient 
HCC1395, a triple-negative breast cancer cell line. Originally derived from a 43-year-old woman with a TNM stage I primary ductal carcinoma in 1990. Carries TP53 mutations, BRCA1/2 alterations and a well-characterized somatic mutation landscape, which is part of why it became the benchmark line.