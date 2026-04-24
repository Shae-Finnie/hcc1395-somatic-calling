# Paired-normal tumour sample variant calling using HCC1395 and HCC1395BL

This project implements a somatic variant calling pipeline using paired tumor and matched normal whole exome sequencing data from the HCC1395/HCC1395BL cell line pair. The data comes from the SEQC2 (Sequencing Quality Control Phase 2) Somatic Mutation Working Group, an FDA-led consortium that sequenced the same patient material at multiple centers to support cross-site reproducibility studies of somatic variant detection. Starting from pre-aligned BAMs, the pipeline runs GATK Mutect2 in tumor-versus-normal mode, applies standard filtering, and annotates variants using Ensembl VEP. Performance is benchmarked against the SEQC2 high-confidence truth set using bcftools isec, with precision and recall reported per variant class. The intent is to walk through a complete, reviewer-defensible somatic calling workflow on a dataset where the answers are already known.

### Directory Structure

```

├── data
│   ├── raw
│   ├── refs
│   ├── resources
│   └── truth_set
├── README.md
├── results
│   ├── annotated
│   ├── contamination
│   ├── coverage
│   ├── isec
│   ├── isec_callable
│   └── mutect2
└── scripts
    ├── 00_reference_dl.sh
    ├── 01_mutect2_caller.sh
    ├── 02_contamination_est.sh
    ├── 03a_mutect2_filter.sh
    ├── 03b_mutect_filter_noncontam.sh
    ├── 04_vep.sh
    ├── 05_isec.sh
    ├── 06_seqc2_benchmark.sh
    └── helpers.md

```

### Original Patient 
HCC1395, a triple-negative breast cancer cell line. Originally derived from a 43-year-old woman with a TNM stage I primary ductal carcinoma in 1990. Carries TP53 mutations, BRCA1/2 alterations and a well-characterized somatic mutation landscape, which is part of why it became the benchmark line.

## Benchmarking against the SEQC2 truth set

The pipeline was evaluated against the SEQC2 v1.2 high-confidence somatic SNV
truth set using `bcftools isec`, in two configurations.

### Against the full WGS truth set

|           | strict | nocontam |
|-----------|:------:|:--------:|
| TP        | 1,542  | 1,641    |
| FP        | 98     | 326      |
| FN        | 38,018 | 37,919   |
| Precision | 0.940  | 0.834    |
| Recall    | 0.039  | 0.041    |
| F1        | 0.075  | 0.079    |

### Restricted to WES-callable regions

Truth set and call set both restricted to regions with tumour coverage ≥20x
AND normal coverage ≥10x, intersected with the SEQC2 high-confidence regions
(see `06_benchmark_callable.sh`).

|           | strict | nocontam |
|-----------|:------:|:--------:|
| TP        | 1,241  | 1,339    |
| FP        | 26     | 199      |
| FN        | 245    | 147      |
| Precision | 0.979  | 0.871    |
| Recall    | 0.835  | 0.901    |
| F1        | 0.901  | 0.886    |

### Interpretation

The first benchmark understates recall because the WGS truth VCF contains
~39,500 variants spread across the whole genome, most of which fall outside
the WES capture and coverage footprint and cannot be called by definition.
Restricting the comparison to regions the WES data could actually call gives
a fair benchmark: F1 rises from ~0.08 to ~0.90, consistent with published
SEQC2 results for Mutect2 on HCC1395 WES.

Within the fair benchmark, the strict filter (with contamination correction)
trades a small recall hit for substantially better precision — 98 fewer TPs
but 173 fewer FPs than nocontam. For curation-oriented downstream use, strict
is preferred.