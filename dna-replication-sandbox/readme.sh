#!/bin/bash

BAMFILE=data/wceGM12878_chr2.bam #data/wgEncodeBroadHistoneGm12878ControlStdAlnRep1.bam
GCBINSIZE=401
PREFIX=wceGM12878
GENOMEFILE=hg19.genome

# Get windows
bedtools makewindows -g ${GENOMEFILE} -w 10000 -s 5000 > hg19_windows_10_5.bed

./get_gc_corrected_readcounts.sh $BAMFILE $GCBINSIZE $PREFIX
