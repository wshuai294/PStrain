#!/bin/bash

script_dir=$(dirname "$0")

mkdir $script_dir/../mpa_v31_CHOCOPhlAn_201901

cd $script_dir/../mpa_v31_CHOCOPhlAn_201901

wget http://cmprod1.cibio.unitn.it/biobakery3/metaphlan_databases/mpa_v31_CHOCOPhlAn_201901.tar
tar -xvf mpa_v31_CHOCOPhlAn_201901.tar

bzip2 -d mpa_v31_CHOCOPhlAn_201901.fna.bz2
bowtie2-build mpa_v31_CHOCOPhlAn_201901.fna mpa_v31_CHOCOPhlAn_201901





