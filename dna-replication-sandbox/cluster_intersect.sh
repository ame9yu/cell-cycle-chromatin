#!/bin/bash

for f in ./tss_counts/WCE/*
do
	base=`basename $f | cut -f 1 -d '.'`
	echo $base
	intersectBed -wa -wb -sorted -a $f -b ./mm9_tss_sorted.bed | cut -f 1,2,3,4,8 | intersectBed -wa -wb -sorted -a stdin -b ./data/simon_cluster_mm9.bed | cut -f 1,2,3,4,5,9  > ./tss_clusters/$base.cluster.bed
	
done	
