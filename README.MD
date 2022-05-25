# PStrain: An Iterative Microbial Strains Profiling Algorithm for Shotgun Metagenomic Sequencing Data

## Install  
```
cd PStrain/scripts
python3 PStrain.py -h
python3 PStrain_V30.py -h (to use Metaphlan3)
```
Note: please adjust `--elbow` while using Metaphlan3, because its value is optimized for Metaphlan2.
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
    * metaphlan2/3
    * GATK-3.5 (java-1.8.0_241)
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

## Run PStrain based on Metaphlan3
PStrain also allows using Metaphlan3 to get species profiles. You can download the Metaphlan3 database db_V30 from https://drive.google.com/drive/folders/1NgBNlfduLwG61P3JMBZts6pVUJn3UR8n?usp=sharing. Also you should install Metaphlan3 by yourself, and let PStrain know the path. Then you can run PStrain with 
```
Usage: python3 PStrain_V30.py [options] -c/--conf <config file> -o/--outdir <output directory> --metaphlan3 <path-to-metaphlan3>

Example: python3 PStrain_V30.py --metaphlan3 /home/wangshuai/miniconda3/bin/metaphlan -c test.config -o test_dir

or

python3 PStrain_V30.py --metaphlan3_output_files exisiting_metaphlan3_results.txt -c test.config -o test_dir 
```
For metaphlan3, we do not build prior genotype frequencies database which will not impact the performance very much. So just ignore --prior parameter. ALso, you can build a prior genotype frequencies database by yourself. I will show how to do this in the following section.
In this way, PStrain will run Metaphlan3 to find the species profile in the sample and profile the strains in each species.

If you have run metaphlan3 already for each file, to save runtime, you can build a file to record 
the metaphlan3 resultfile of each sample in each line (In particular,  "--tax_lev s" should be added while running metaphlan3.). 
Please afford this file to PStrain_V30.py with the parameter "--metaphlan3_output_files".
The file should be like
```
sample1_metaphlan3_output.txt
sample2_metaphlan3_output.txt
sample3_metaphlan3_output.txt
...
``` 
Then PStrain will skip running metaphlan3, and use the existing metaphlan3 result files.
## Run PStrain based on Metaphlan2

```
Example: python3 PStrain.py -p 10 -n 8 --similarity 0.95 -o ./outdir -c config.txt \
--dbdir /home/wangshuai/strain/00.simulation/15.needle/db \
--prior /home/wangshuai/strain/00.simulation/15.needle/db/prior_beta.pickle\
--metaphlan2  /path-to/metaphlan2
```
### command-line options
```
PStrain: profile strains in shotgun metagenomic sequencing reads.

required arguments:
  -c , --conf           The configuration file of the input samples.
  -o , --outdir         The output directory.

optional arguments:
  -h, --help            show this help message and exit
  -p , --proc           The number of process to use for parallelizing the whole pipeline (default is 1).
  -n , --nproc          The number of CPUs to use for parallelizing the mapping with bowtie2(default is 1).
  -w , --weight         The weight of genotype frequencies while computing loss, then the weight of linked read type frequencies is 1-w. The
                        value is between 0~1. (default is 0.0)
  --lambda1             The weight of prior knowledge while rectifying genotype frequencies. The value is between 0~1. (default is 0.0)
  --lambda2             The weight of prior estimation while rectifying second order genotype frequencies. The value is between 0~1. (default is
                        0.0)
  --species_dp          The minimum depth of species to be considered in strain profiling step (default is 5).
  --snp_ratio           The SNVs of which the depth are less than the specific ratio of the species's mean depth would be removed. (default is
                        0.45).
  --qual                The minimum quality score of SNVs to be considered in strain profiling step (default is 20).
  --similarity          The similarity cutoff of hierachical clustering in merge step (default is 0.95).
  --elbow               The cutoff of elbow method while identifying strains number. If the loss reduction ratio is less than the cutoff, then
                        the strains number is determined. Default is 0.24.
  --bowtie2             Path to bowtie2 binary. If your platform is not Linux, you need to specify your own bowtie2 binary.
  --bowtie2-build       Path to bowtie2 binary. If your platform is not Linux, you need to specify your own bowtie2-build binary.
  --samtools            Path to samtools binary (default version is in the packages path). If your platform is not Linux, you need to specify
                        your own samtools binary.
  --metaphlan3          Path to metaphlan3 (default version is in the packages path).
  --metaphlan3_output_files
                        If you have run metaphlan3 already, give metaphlan3 result file in each line, the order should be the same with config
                        file. In particular, '--tax_lev s' should be added while running metaphlan3.
  --gatk                Path to gatk binary (default version is in the packages path).
  --picard              Path to picard binary (default version is in the packages path).
  --dbdir_V30           Path to marker gene database (default is in the ../db_V30 path).
  --prior               The file of prior knowledge of genotype frequencies in the population. Not providing this is also ok.
```


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

## Analyzing the results of PStrain
First, we can use merge.py cluster the strains obtained from all the 
samples with user-defined parameters.
```
usage: python3 merge.py [options] -c/--conf <config file> -o/--outdir <output directory>

Merge the results from all of the samples.

required arguments:
  -c , --conf     The configuration file of the input samples, which is same as mentioned above.
  -o , --outdir   The output directory.

optional arguments:
  -h, --help      show this help message and exit
  --similarity    The similarity cutoff of hierachical clustering in merge step (default is 0.95).
```
Furthermore, we can adopt [**PStrain-tracer**](https://github.com/deepomicslab/PStrain-tracer) for downstream analysis and visulization.

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

## Run PStrain on your concerned species
You can build the species-specific pipeline easily by yourself, the code single_species.py in the scripts/ folder can be very useful.

You can build the pipeline as follow:
```
Step 1. Given the raw fastq file of a sample, run Metaphlan3 to get the species 
        abundance.
Step 2. For each species in the sample, extract the species' corresponding marker 
        genes from Metaphlan3 as the reference.
Step 3. For each species, map sample's reads to the reference of the species with 
        bowtie2 and call SNV with GATK, you will get the BAM and VCF file.
Step 4. For each species, run python3 single_species.py [options] -b/--bam <bam file>
         -v/--vcf <vcf file> -o/--outdir <output directory>.
Step 5. Then you get the strain profiles of each species in each sample, you can now 
        analyze them.   
```
You can also use other marker gene database in the same way.

## Build your own prior database
Although PStrain's performance is good enough without the prior database except for the gene with too low depth. You can build your own prior database to improve the     performance. PStrain will assume the prior beta is 0.5 if not finding prior knowledge.

To generate the prior database, please follow these steps:

1. Run PStrain.py (Metaphlan2) or PStrain_V30.py (Metaphlan3) directly to get the bam file in each sample, and call SNP with GATK in gvcf formate which will indicate the depth for each base.  
2. Merge the SNP by computing mean frequency of each base in all samples. And generate a file named "prior_beta.txt" in this formate:
```
locus   A       T       C       G
gi|378760316|ref|NZ_AGDG01000038.1|:8694-9629|Bacteroides_faecis_517    1       0       0       0
gi|410936685|ref|NZ_AJRF02000012.1|:54814-55320|Enterococcus_faecium_299        0       1       0       0
gi|139439993|ref|NZ_AAVN02000016.1|:7311-8633|Collinsella_aerofaciens_783       0.0102827763496144      0.0205655526992288      0       0.969151670951157
gi|239633764|ref|NZ_GG670286.1|:165060-166319|Enterococcus_gallinarum_626       0       0       0       1
gi|345651640|ref|NZ_JH114383.1|:276898-279936|Bacteroides_vulgatus_2725 0       0       0       1
GeneID:16385027|Lactococcus_phage_jm2_95        1       0       0       0
gi|488673303|ref|NZ_KB850950.1|:c879018-878179|Clostridium_hathewayi_511        0       0       0       1
```
3. Then you can convert it to pickle formate by
```
import pickle
popu={}
f=open('prior_beta.txt','r')
for line in f:
    break
for line in f:
    line=line.strip()
    array=line.split()
    atcg=array[1:]
    popu[array[0]]=atcg  
 with open('prior_beta.pickle', 'wb') as f:
     pickle.dump(popu, f, pickle.HIGHEST_PROTOCOL) 
```
Then please afford the file to PStrain with parameter --prior.

## Citation
Shuai Wang, Yiqi Jiang, Shuaicheng Li, PStrain: An Iterative Microbial Strains Profiling Algorithm for Shotgun Metagenomic Sequencing Data, Bioinformatics, , btaa1056, https://doi.org/10.1093/bioinformatics/btaa1056

## Getting help
Should you have any queries, please feel free to contact me, I will reply as soon as possible (swang66-c@my.cityu.edu.hk).
