#!/bin/bash

BAMFILE=$1
CHROM=$2
WINDOWS=$3
OUTDIR=$4

samtools mpileup ${BAMFILE} | awk '{print $1 "\t" $2 "\t" $2+1 "\t" $4}' | grep ${CHROM} | \
    intersectBed -a ${WINDOWS} -b stdin -wa -wb -sorted | cut -f 1,2,3,7 | \
    bedtools groupby -g 1,2,3 -c 4 -o sum > ${OUTDIR}/$(basename ${BAMFILE} .bam).counts.bed

