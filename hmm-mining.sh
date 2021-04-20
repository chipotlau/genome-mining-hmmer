#!/bin/bash

# this script will take all predicted protein fasta files in a directory and use \
# HMMER to search for a particular protein domain, then pull out the proteins with hits \
# it will use the name of the protein files to generate individual directories for each file \
# for example, the peptide file Nomascus_leucogenys.pep.all.fa will be used to produce \
# a directory called Nomascus_leucogenys

#### BEFORE YOU BEGIN ####
##set your PATHS and variables

#PATH for working directory
WKDIR='/home/emily.lau/projects/protein/ensembl'

#PATH for directory containing protein domain alignment
HMMDIR='/home/emily.lau/projects/protein'

#name of your protein domain alignment file
prot='seed.fasta'

#### BEGIN ####

#this will grab the name of all the files in the directory

cd $WKDIR
FILES=$(basename "$WKDIR/*")

#builds hmm profile
hmmbuild $HMMDIR/$prot.hmm $HMMDIR/$prot

#sets variable name for your hmm profile
hmmprofile="$HMMDIR/$prot.hmm"

#for loop to run this for all files in directory
for f in $FILES
do
	cd $WKDIR;
	species=${f%%.*}; #truncate the peptide file name to generate ID used for subsequent directory formation and output file name
	mkdir $species;
	hmmsearch -A $species.sto $hmmprofile $f; #saves a multiple alignment of all significant hits
	mv $species.sto $species; #moves alignment to specific species folder
	cd $species;
	esl-reformat fasta $species.sto > $species.domain.fa; #convert alignment to FASTA format
done
