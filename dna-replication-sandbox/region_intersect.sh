#!/bin/bash

for f in ./tss_counts_all/*K4me3*.merged.sorted.counts.bed
do 
	echo $f
	dir=`basename $f | cut -f 1 -d '.' | cut -f 1,2,3 -d '_'`
	intersectBed -wa -wb -sorted -a $f -b ./regions_sep/exp1_0hr_K4me3.regions.bed.sorted.rm | cut -f 1,2,3,4 | uniq > ./tss_clusters_all/peaksonly/$dir.filtered.bed 
	intersectBed -wa -wb -sorted -a tss_clusters_all/peaksonly/$dir.filtered.bed -b ./data/simon_cluster_mm9.bed | cut -f 5,6,7,8,4 | bedtools groupby -g 2,3,4,5 -c 1 -o sum > ./tss_clusters_all/peaksonly/$dir.filtered.clustered.bed
done
