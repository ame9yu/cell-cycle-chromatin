#!/bin/sh

for f in ./bam/exp*K4me3*.bam
do 
	echo $f
	bash ./get_binned_counts.sh $f chr2 mm9_tss_sorted.bed ./tss_counts_all/
done

for f in ./bam/exp*WCE*.bam
do 
	echo $f
	bash ./get_binned_counts.sh $f chr2 mm9_tss_sorted.bed ./tss_counts_all/
done
