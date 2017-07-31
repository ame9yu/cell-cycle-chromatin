#!/bin/bash

reffa=/storage/resources/dbase/mouse/mm9/mm9.fa

####------------------------
# make tag directories
####------------------------

ac=./bam/*K27ac*bam
for f in $ac
do 
	dirname=`basename $f | cut -f 1,2,3 -d '_'`
	echo $dirname
	makeTagDirectory ./tags_K27ac/$dirname -genome /storage/resources/source/homer/data/genomes/mm9 -checkGC $f
	makeUCSCfile ./tags_K27ac/$dirname -o auto
done

for f in ./bam/*WCE*bam
do
	dirname=`basename $f | cut -f 1,2,3 -d '_'`
	makeTagDirectory ./tags_wce/$dirname -genome /storage/resources/source/homer/data/genomes/mm9 -checkGC $f
	makeUCSCfile ./tags_wce/$dirname -o auto
done 

me=./bam/*K4me3*bam
for f in $me
do
	dirname=`basename $f | cut -f 1,2,3 -d '_'`
	echo $dirname
	makeTagDirectory ./tags_K4me3/$dirname -genome /storage/resources/source/homer/data/genomes/mm9 -checkGC $f
	makeUCSCfile ./tags_K4me3/$dirname -o auto
done


####----------------------------
# Find peaks
####----------------------------

for dir in ./tags_K*/*
do
	dirname=`basename $dir | cut -f 1,2 -d '_'`
	echo $dirname
	control='./tags_wce/'$dirname'_WCE/'
	findPeaks $dir -i $control -style histone -o auto
done
