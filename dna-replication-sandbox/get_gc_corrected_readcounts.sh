#!/bin/bash

BAMFILE=$1
GCBINSIZE=$2
PREFIX=$3

WINDOWS=hg19_windows_10_5_chr2.bed #hg19_windows_10_5.bed
GENOMEFA=/Users/gymrek/resources/genomes/hg19/hg19.fa #/humgen/atgu1/fs03/wip/gymrek/genomes/hg19.fa
GENOMEFILE=hg19.genome

#############################
# GC CONTENT CORRECTION
# Each bp, get GC content for 401bp centered on that position
# Regress GC vs. coverage
# Get residual for each position as input to next step
#############################

# Get readcount per bp
samtools mpileup ${BAMFILE} | cut -f 1,2,4 > ${PREFIX}_pileup.tab

# Get 401bp centered at each bp with reads
cat ${PREFIX}_pileup.tab | awk -v"gcbin=$GCBINSIZE" '{print $1 "\t" $2-int(gcbin/2) "\t" $2+int(gcbin/2)+1}' | \
    bedtools nuc -fi ${GENOMEFA} -bed stdin | cut -f 1,2,3,5 | grep -v "\#" > ${PREFIX}_gcwindows.bed

# Regress read count on GC, get residuals
paste ${PREFIX}_pileup.tab ${PREFIX}_gcwindows.bed | cut -f 1,2,3,7  > ${PREFIX}_gcwindows_counts.bed
./get_gc_residuals.py ${PREFIX}_gcwindows_counts.bed > ${PREFIX}_gccorrected_counts.tab

#############################
# GET COVERAGE WINDOWS
#############################
cat ${PREFIX}_gccorrected_counts.tab | grep -v chrom | awk '{print $1 "\t" $2 "\t" $2+1 "\t" $3 "\t" $4}' | \
    intersectBed -a ${WINDOWS} -b stdin -wa -wb -sorted | cut -f 1,2,3,7,8 | bedtools groupby -g 1,2,3 -c 4,5 -o sum,sum > \
    ${PREFIX}_coveragewindows.bed
