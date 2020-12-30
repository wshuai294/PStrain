# PStrain: An Iterative Microbial Strains Profiling Algorithm for Shotgun Metagenomic Sequencing Data

## Install  
```
cd PStrain/scripts
python3 PStrain.py -h
```
## Dependencies 
* Python 3.7.0 or above  
* Python libraries:  
    * Numpy  
    * Scipy  
    * Pandas  
    * Pulp
    * Pysam  
    * pickle
    * gzip

PStrain need two database file, one is the metaphlan2 marker gene database, the other is the prior genotype frequencies database. We have uploaded the two database in the db/ folder to the link https://drive.google.com/drive/folders/1NgBNlfduLwG61P3JMBZts6pVUJn3UR8n?usp=sharing, you can directly download the db/ folder, and put it in the same path with the scripts/ folder. PStrain could use them by default. Also, you can appoint the path of these two database by corresponding arguments --dbdir and --prior.


PStrain relies on these softwares, we have uploaded the binary file of them to the folder packages/ in the link https://drive.google.com/drive/folders/1NgBNlfduLwG61P3JMBZts6pVUJn3UR8n?usp=sharing, you can directly download the packages/ folder, and put it in the same path with the scripts/ folder. PStrain could use them by default. Also, you can install them by yourself, and appoint them by --samtools, --bowtie2-build, --bowtie2, --metaphlan2, --gatk, and --picard arguments.   
* Third party pipelines:
    * SamTools-1.3.1
    * bowtie2-2.3.1
    * metaphlan2
    * GATK-3.5
    * picard-tools-2.1.0

 Then you can call PStrain.py in the scripts/ folder. 


## Basic Usage  

```
Usage: python3 PStrain.py [options] -c/--conf <config file> -o/--outdir <output directory>
```
The config file should follow the format, for Pair-end reads:
```
//  
sample: [sample1_ID]  
fq1: [forward reads fastq]  
fq2: [reverse/mate reads fastq]  
//  
sample: [sample2_ID]  
fq1: [forward reads fastq]  
fq2: [reverse/mate reads fastq]  
... 
```
For Single-end reads:
```
//  
sample: [sample1_ID]  
fq1: [single end reads fastq]  
fq2:  
//  
sample: [sample2_ID]  
fq1: [single end reads fastq]  
fq2:  
... 
```
## Citation
Shuai Wang, Yiqi Jiang, Shuaicheng Li, PStrain: An Iterative Microbial Strains Profiling Algorithm for Shotgun Metagenomic Sequencing Data, Bioinformatics, , btaa1056, https://doi.org/10.1093/bioinformatics/btaa1056

## Getting help
Should you have any queries, please feel free to contact me, I will reply as soon as possible..(swang66-c@my.cityu.edu.hk)

## Interpret output
In the output directory specified by "-o", there are directories for each sample named by sample ID and one directory named merge.  

In the directory of one specific sample, you will find a folder called "result", in which you can find the below files and directories:
```
strain_RA.txt  
strain_merged_RA.txt 
species1_seq.txt
species2_seq.txt
...

```
The formats for "strain_RA.txt" and "strain_merged_RA.txt" are similar. An example is as below:
```
# Species	Species_RA	Strain_ID	Cluster_ID	Strain_RA
Escherichia_coli 88.00 str-1 clu-1 0.1
Escherichia_coli 88.00 str-2 clu-2 0.2
Escherichia_coli 88.00 str-3 clu-3 0.7
Leifsonia_rubra 12.00 str-1 clu-1 0.4
Leifsonia_rubra 12.00 str-2 clu-2 0.6
```
This means in this sample, there are two species: Escherichia coli with three strains and Leifsonia rubra with two strains.   

* Species_RA column means the species relative abundance in the sample. 

* Strain_ID column means the strains ID of each species in the sample.  

* Cluster_ID column means the strains' corresponding cluster in all of the samples.

* Strain_RA column means the strains abundance of each species in the sample. 

In the merge directory, you can find below files.
```
strain_number.txt
species_1_seq.txt
species_1_clu.txt
species_2_seq.txt
species_2_clu.txt
...
```
* "strain_number.txt" contains the strain number of each species in  all of the samples.

* "species_seq.txt" contains the strain sequence of in all of the samples.

* "species_clu.txt" contains the consensus sequence of each strains cluster in all of the samples.

The file listed below is one *_clu.txt example, the formate of *_clu.txt and *_seq.txt are similar.
```
# Gene	Locus	Ref	Alt	clu-1	clu-2	clu-3	clu-4	clu-5	
gi|545276179|ref|NZ_KE701962.1|:c548151-546829	90	T	G	1	0	0	1	1	
gi|545276179|ref|NZ_KE701962.1|:c548151-546829	303	G	A	0	1	0	1	1	
gi|545276179|ref|NZ_KE701962.1|:c548151-546829	310	A	T	0	0	1	0	1	
gi|545276179|ref|NZ_KE701962.1|:c548151-546829	312	C	A	1	1	1	0	0
...
```
Gene, Locus, Ref, Alt clolumns represent the locus, following columns means the composition of the consensus sequence of each cluster.

## Full command-line options

```
PStrain: profile strains in shotgun metagenomic sequencing reads.

Example: python3 PStrain.py -p 10 -n 8 --similarity 0.95 -o ./outdir -c config.txt \
--dbdir /home/wangshuai/strain/00.simulation/15.needle/db \
--prior /home/wangshuai/strain/00.simulation/15.needle/db/prior_beta.pickle

required arguments:
  -c , --conf       The configuration file of the input samples.
  -o , --outdir     The output directory.

optional arguments:
  -h, --help        show this help message and exit
  -p , --proc       The number of process to use for parallelizing the whole
                    pipeline (default is 1).
  -n , --nproc      The number of CPUs to use for parallelizing the mapping
                    with bowtie2(default is 1).
  -w , --weight     The weight of genotype frequencies while computing loss,
                    then the weight of linked read type frequencies is 1-w.
                    The value is between 0~1. (default is 0.0)
  --lambda1         The weight of prior knowledge while rectifying genotype
                    frequencies. The value is between 0~1. (default is 0.0)
  --lambda2         The weight of prior estimation while rectifying second
                    order genotype frequencies. The value is between 0~1.
                    (default is 0.0)
  --species_dp      The minimum depth of species to be considered in strain
                    profiling step (default is 5).
  --snp_ratio       The SNVs of which the depth are less than the specific
                    ratio of the species's mean depth would be removed.
                    (default is 0.45).
  --qual            The minimum quality score of SNVs to be considered in
                    strain profiling step (default is 20).
  --similarity      The similarity cutoff of hierachical clustering in merge
                    step (default is 0.95).
  --elbow           The cutoff of elbow method while identifying strains
                    number. If the loss reduction ratio is less than the
                    cutoff, then the strains number is determined.
  --bowtie2         Path to bowtie2 binary. If your platform is not Linux, you
                    need to specify your own bowtie2 binary.
  --bowtie2-build   Path to bowtie2 binary. If your platform is not Linux, you
                    need to specify your own bowtie2-build binary.
  --samtools        Path to samtools binary (default version is in the
                    packages path). If your platform is not Linux, you need to
                    specify your own samtools binary.
  --metaphlan2      Path to metaphlan2 script (default version is in the
                    packages path).
  --gatk            Path to gatk binary (default version is in the packages
                    path).
  --picard          Path to picard binary (default version is in the packages
                    path).
  --dbdir           Path to marker gene database (default is in the ../db
                    path).
  --prior           The file of prior knowledge of genotype frequencies in the
                    population.
```

## Single Species Mode
If there is only one species, you can map reads and call SNPs by yourself. After that, you can use single_species.py from scripts/ folder to profile strains.

If you have the prior knowledge of strains number, you can add this info to argument -k/--strainsNum. Once the -k/--strainsNum argument is set to 1, the consensus sequence with major alleles will be generated.

Detailed usage information can be found as follows:
```
Usage: python3 single_species.py [options] -b/--bam <bam file> -v/--vcf <vcf file> -o/--outdir <output directory>
Example: python3 single_species.py -b mapped.bam -v mapped.vcf.gz --prior /home/wangshuai/strain/00.simulation/15.needle/db/prior_beta.pickle -o phase_result -k 2

Before using this script, you should align the reads to your reference, and call SNPs. Then you can provide the bam and vcf file. Once you have the prior knowledge of the strains number, you can provie it the to script by -k/--strainsNum parameter. Otherwise,it will choose the strains number by elbow method. 
Help information can be found by python3 single_species.py -h/--help, additional information can be found in README.MD or https://github.com/wshuai294/PStrain.

PStrain: phase strains in samples with single species.

required arguments:
  -b , --bam          The bam file of the input samples.
  -v , --vcf          The vcf file of the input samples.
  -o , --outdir       The output directory.

optional arguments:
  -h, --help          show this help message and exit
  -k , --strainsNum   The number of strains in the sample (default is chosen
                      by elbow method).
  --snp_dp            The minimum depth of SNPs to be considered in strain
                      profiling step (default is 5).
  --prior             The file of prior knowledge of genotype frequencies in
                      the population.
  --elbow             The cutoff of elbow method while identifying strains
                      number. If the loss reduction ratio is less than the
                      cutoff, then the strains number is determined.
  --qual              The minimum quality score of SNVs to be considered in
                      strain profiling step (default is 20).
  -w , --weight       The weight of genotype frequencies while computing loss,
                      then the weight of linked read type frequencies is 1-w.
                      The value is between 0~1. (default is 0.0)
  --lambda1           The weight of prior knowledge while rectifying genotype
                      frequencies. The value is between 0~1. (default is 0.0)
  --lambda2           The weight of prior estimation while rectifying second
                      order genotype frequencies. The value is between 0~1.
                      (default is 0.0)
```

## Prepare your own marker gene database
PStrain use the marker gene database of metaphlan2 (V20), you can also prepare your own database, and add the path to to argument --dbdir.

There should be two files in the database folder, the first one is marker_gene.fna, it is the sequence of marker gene in fasta formate.
An example is as follow:
```
>gi|345004010|ref|NC_015954.1|:c1336247-1335993
ATGCCCGAACACGTCGGCACCACCGACCCCGACGGGGTTGATTTCGGCTGGGTGATGCAG
AGCAC
>gi|345004010|ref|NC_015954.1|:2775135-2775383
ATGGCGGAGACCCTCACAGAACTCTCCCAACGGAATGAAGCGTTCTGGATTGGTTTGGCT
CTATTCCTTCTCGGAGTGA
```
The other file is species_markers.txt, it has two colums, the first colum represent gene name, the second colum is the corresponding species name of the gene.
An example is as follow:
```
gi|483970126|ref|NZ_KB891629.1|:c6456-5752 s__Streptomyces_sp_KhCrAH_244
gi|389575461|ref|NZ_CM001487.1|:2807701-2808822 s__Eubacterium_cellulosolvens
gi|225074862|ref|NZ_GG661976.1|:131927-134068 s__Helicobacter_winghamensis
gi|397677603|ref|NC_018149.1|:637056-637958 s__Mycoplasma_wenyonii
gi|284161128|ref|NC_013741.1|:c752279-751428 s__Archaeoglobus_profundus
```

