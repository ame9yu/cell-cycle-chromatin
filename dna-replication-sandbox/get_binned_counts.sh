#!/bin/bash

BAMFILE=$1
CHROM=$2
WINDOWS=$3
OUTDIR=$4

samtools view -b ${BAMFILE} chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 | \
    samtools mpileup - | awk '{print $1 "\t" $2 "\t" $2+1 "\t" $4}' | \
    intersectBed -a ${WINDOWS} -b stdin -wa -wb -sorted | cut -f 1,2,3,7 | \
    bedtools groupby -g 1,2,3 -c 4 -o sum > ${OUTDIR}/$(basename ${BAMFILE} .bam).counts.bed

