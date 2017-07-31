#!/bin/bash

for f in ./tss_clusters_all/exp*bed
do 
	echo $f
	cut -f 1,2,3 $f | sort | uniq -d > ./tss_clusters_all/multi_tor.txt
	cut -f 1,2,3 ./tss_clusters_all/multi_tor.txt | grep -f - -v -F $f > $f.rmdup
done
