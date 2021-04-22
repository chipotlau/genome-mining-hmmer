#!/bin/bash

WKDIR='/home/emily.lau/projects' #set your working directory
FILES=$(basename "$WKDIR/*.fa") #grab the name of the files you want to clean up

for f in $FILES
do
	sed -i 's/\s.*$//g' $f; #remove everything after the first space
	species=${f%%.*}; #grab the first part of the file name
	sed -i "s/^>.*/&_$species/g" $f; #add the first part of the file name to the end of each fasta header
done
