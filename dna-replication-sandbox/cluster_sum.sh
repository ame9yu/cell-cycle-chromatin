#!/bin/bash

for f in ./filtered_tss_counts/exp*bed
do
	echo $f
	sort -k1,1V -k2,2n -i $f > $f.sorted	#sort first
	dirname=`basename $f | cut -f 1 -d '.'`
	intersectBed -wa -wb -sorted -a $f.sorted -b ./data/simon_cluster_mm9.sorted.bed | bedtools groupby -g 5,6,7,8 -c 4 -o sum > ./tss_clusters_all/$dirname.clustersum.filtered.bed
done
