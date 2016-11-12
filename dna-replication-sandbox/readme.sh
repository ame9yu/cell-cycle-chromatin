#!/bin/bash

BAMFILE=data/wgEncodeBroadHistoneGm12878ControlStdAlnRep1.bam
GCBINSIZE=401
PREFIX=wceGM12878
GENOMEFA=/humgen/atgu1/fs03/wip/gymrek/genomes/hg19.fa
GENOMEFILE=hg19.genome

# Get windows
bedtools makewindows -g ${GENOMEFILE} -w 10000 -s 5000 > hg19_windows_10_5.bed

bsub -q week -eo gc.err -oo gc.out ./get_gc_corrected_readcounts.sh $BAMFILE $GCBINSIZE $PREFIX
