#!/bin/sh

for f in bam/exp2*WCE*bam
do
	echo $f
	./get_binned_counts.sh $f chr2 mm9_windows_10_5.bed ./counts 
done
