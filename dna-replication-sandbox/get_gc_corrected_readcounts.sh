#!/bin/bash

BAMFILE=$1
GCBINSIZE=$2
GCSHIFTSIZE=$3
PREFIX=$4

GENOMEFILE=hg19.genome

# Generate intervals for GC correction step and for read count windows
bedtools makewindows -g $GENOMEFILE -w $GCBINSIZE -s $GCSHIFTSIZE > ${PREFIX}_gcwindows.bed
