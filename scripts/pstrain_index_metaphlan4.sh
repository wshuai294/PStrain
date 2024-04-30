#!/bin/bash



script_dir=$(dirname "$0")
mkdir $script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403

cd $script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403

wget http://cmprod1.cibio.unitn.it/biobakery4/metaphlan_databases/mpa_vJun23_CHOCOPhlAnSGB_202403.tar
tar -xvf script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403.tar

bzip2 -d script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403.fna.bz2
bowtie2-build script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403.fna script_dir/../mpa_vJun23_CHOCOPhlAnSGB_202403





