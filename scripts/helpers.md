# A list of helpful commands to use while going through this pipeline 


### check header of bam to assess which ref it was aligned to with BWA
samtools view -H WES_IL_T_1.bwa.dedup.bam | head -50

### Checking initial bams

samtools view -H WES_IL_N_1.bwa.dedup.bam | grep "^@RG"

samtools view -H WES_IL_T_1.bwa.dedup.bam | grep "^@PG"

The normal sample name for the Mutect2 -normal flag is WES_IL_N_1 (from the SM: field), and the BAMs were aligned with BWA on the Illumina platform (confirmed by PP:bwa and PL:ILLUMINA).