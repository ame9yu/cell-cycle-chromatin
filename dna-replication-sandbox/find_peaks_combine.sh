#!/bin/bash

reffa=/storage/resources/dbase/mouse/mm9/mm9.fa

####------------------------
# make tag directories
####------------------------

for f in ./bam/*combine*
do
	dirname=`basename $f | cut -f 1,2 -d '_'`
	echo $dirname
	makeTagDirectory ./tags_combined/$dirname -genome /storage/resources/source/homer/data/genomes/mm9 -checkGC $f
	makeUCSCfile ./tags_combined/$dirname -o auto
done

####----------------------------
# Find peaks
####----------------------------

for dir in ./tags_combined/*
do
	dirname=`basename $dir | cut -f 1 -d '_'`
	echo $dirname
	control='./tags_combined/'$dirname'_WCE/'
	findPeaks $dir -i $control -style histone -o auto
done
