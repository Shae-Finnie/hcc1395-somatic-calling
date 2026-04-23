# A list of helpful commands to use while going through this pipeline 


### check header of bam to assess which ref it was aligned to with BWA
samtools view -H WES_IL_T_1.bwa.dedup.bam | head -50

### Checking initial bams and bais

samtools view -H WES_IL_N_1.bwa.dedup.bam | grep "^@RG"

samtools view -H WES_IL_T_1.bwa.dedup.bam | grep "^@PG"

samtools idxstats data/raw/WES_IL_T_1.bwa.dedup.bam | head -5
- should print out chr x with bases

The normal sample name for the Mutect2 -normal flag is WES_IL_N_1 (from the SM: field), and the BAMs were aligned with BWA on the Illumina platform (confirmed by PP:bwa and PL:ILLUMINA).

### Post Mutect2 calling inspections

bcftools view -H somatic.vcf.gz | wc -l
- total raw calls against the matched normal

bcftools view -H somatic.vcf.gz | cut -f1 | sort | uniq -c
- per-chromosome distribution of mutations

#### example output

-f1 | sort | uniq -c
1799 chr1
 644 chr10
 921 chr11
 996 chr12
 375 chr13
 824 chr14
 777 chr15
1570 chr16
 825 chr17
 422 chr18
 904 chr19
1305 chr2
 494 chr20
 273 chr21
 458 chr22
1210 chr3
 850 chr4
 938 chr5
2744 chr6
1405 chr7
 768 chr8
 813 chr9
1132 chrX
  12 chrY

bcftools view somatic.vcf.gz chr17:7660000-7700000 | grep -v "^##"
- check TP53 

#### example output

#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	WES_IL_N_1	WES_IL_T_1
chr17	7675088	.	C	T	.	.	AS_SB_TABLE=141,109|87,90;DP=445;ECNT=1;ECNTH=1;MBQ=42,37;MFRL=185,184;MMQ=60,60;MPOS=22;NALOD=-2.327;NLOD=62.26;POPAF=6;TLOD=652.9GT:AD:AF:DP:F1R2:F2R1:FAD:SB	
0/0:250,0:0.004701:250:90,0:107,0:207,0:141,109,0,0	0/1:0,177:0.994:177:0,70:0,67:0,149:0,0,87,90

normal(WES_IL_N_1): 0 alt reads, 250 ref, AF = 0.004
tumour(WES_IL_T_1): 177 alt reads, 0 ref, AF = 0.994 -> TLOD=652.9 (very high)