#!/bin/bash

BAMDIR=$1
WINDOWS=$2
OUTDIR=$3

###
# BAM TO COUNTS.BED
###
for f in ${BAMDIR}/*
do
	samtools idxstats ${BAMFILE} | cut -f 1 | sed -n 2,20p | \
		xargs samtools view -b ${BAMFILE} | \
	    samtools mpileup - | awk '{print $1 "\t" $2 "\t" $2+1 "\t" $4}' | \
	    intersectBed -a ${WINDOWS} -b stdin -wa -wb -sorted | cut -f 1,2,3,7 | \
	    bedtools groupby -g 1,2,3 -c 4 -o sum > ${OUTDIR}/$(basename ${BAMFILE} .bam | cut -f 1 -d '.').counts.bed
done

###
# FILTERING: get the peaks only
###
# for f in ${OUTDIR}/*
# do
# 	name=`basename $f | cut -f 1 -d '.' | cut -f 1,2,3 -d '_'`
# 	intersectBed -wa -wb -sorted -a $f -b ./regions_sep/exp1_0hr_K4me3.regions.bed.sorted.rm | cut -f 1,2,3,4 | uniq > ./${OUTDIR}/peaksonly/$name.filtered.bed 
# 	intersectBed -wa -wb -sorted -a ${OUTDIR}/peaksonly/$name.filtered.bed -b ./data/simon_cluster_mm9.bed | cut -f 5,6,7,8,4 | bedtools groupby -g 2,3,4,5 -c 1 -o sum > ./${OUTDIR}/peaksonly/$name.filtered.clustered.bed
# done





