#!/bin/bash

BAMDIR=./bam
GENOMEFILE=mm9.genome

WINDOWS=mm9_windows_10_5.bed
CHROM=chr1 # focus on one chrom for now
OUTDIR=./counts
LOGDIR=./log

# Get windows
bedtools makewindows -g ${GENOMEFILE} -w 10000 -s 5000 > ${WINDOWS}

# For each BAM file, get counts
for bam in $(ls ${BAMDIR}/*.bam)
do
    bsub -q week -eo ${LOGDIR}/$(basename ${bam} .bam).err -oo ${LOGDIR}/$(basename ${bam} .bam).out \
        ./get_binned_counts.sh ${bam} ${CHROM} ${WINDOWS} ${OUTDIR}
done
