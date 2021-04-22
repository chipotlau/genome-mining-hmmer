#!/bin/bash

WKDIR='/home/emily.lau/projects/protein/ensembl'

cd $WKDIR

find . -regex ".*domain.fa" -exec cat {} \; > mined_stdomains.fa
