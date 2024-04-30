#!/bin/bash



script_dir=$(dirname "$0")
mkdir $script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403

cd $script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403

wget http://cmprod1.cibio.unitn.it/biobakery4/metaphlan_databases/mpa_vJun23_CHOCOPhlAnSGB_202403.tar
tar -xvf mpa_vJun23_CHOCOPhlAnSGB_202403.tar

bzip2 -d mpa_vJun23_CHOCOPhlAnSGB_202403.fna.bz2
bowtie2-build mpa_vJun23_CHOCOPhlAnSGB_202403.fna mpa_vJun23_CHOCOPhlAnSGB_202403





