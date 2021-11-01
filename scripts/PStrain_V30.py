#!/usr/bin/env python3

from argparse import ArgumentParser
from my_imports import *
import merge
import pipeline_V30

Usage = \
"""%(prog)s [options] -c/--conf <config file> -o/--outdir <output directory>

The config file should follow the format:

//
sample: [sample1_ID]
fq1: [forward reads fastq]
fq2: [reverse/mate reads fastq]
//
sample: [sample2_ID]
fq1: [forward reads fastq]
fq2: [reverse/mate reads fastq]
...

Help information can be found by %(prog)s -h/--help, config file format for single end reads , and additional information can be found\
 in README.MD or https://github.com/wshuai294/PStrain.
"""
scripts_dir=sys.path[0]+'/'
parser = ArgumentParser(description="PStrain: profile strains in shotgun metagenomic sequencing reads.",prog='python3 PStrain.py',usage=Usage)
optional=parser._action_groups.pop()
required=parser.add_argument_group('required arguments')
#necessary parameter
required.add_argument("-c", "--conf",help="The configuration file of the input samples.",dest='cfgfile',metavar='')
required.add_argument("-o", "--outdir",help="The output directory.",dest='outdir',metavar='')
#alternative parameter
optional.add_argument("-p", "--proc",help="The number of process to use for parallelizing the whole pipeline (default is 1)."\
    ,dest='proc',metavar='',default=1, type=int)
optional.add_argument("-n", "--nproc",help="The number of CPUs to use for parallelizing the mapping with bowtie2(default is 1)."\
    ,dest='nproc',metavar='',default=1, type=int)
optional.add_argument("-w", "--weight",help="The weight of genotype frequencies while computing loss, then the weight of\
 linked read type frequencies is 1-w. The value is between 0~1. (default is 0.0)",dest='weight',metavar='',default=0.3, type=float)
optional.add_argument( "--lambda1",help="The weight of prior knowledge while rectifying genotype frequencies. \
The value is between 0~1. (default is 0.0)",dest='lambda1',metavar='',default=0.0, type=float)
optional.add_argument( "--lambda2",help="The weight of prior estimation while rectifying second order genotype frequencies. \
The value is between 0~1. (default is 0.0)",dest='lambda2',metavar='',default=0.0, type=float)
optional.add_argument("--species_dp",help="The minimum depth of species to be considered in strain profiling step (default is 5).",\
    dest='species_dp',metavar='',default=5, type=int)
# optional.add_argument("--snp_dp",help="The minimum depth of SNVs to be considered in strain profiling step (default is 6).",\
    # dest='snp_dp',metavar='',default=6, type=int)
optional.add_argument("--snp_ratio",help="The SNVs of which the depth are less than the specific ratio of the species's mean depth would be removed. (default is 0.45).",\
    dest='snp_dp',metavar='',default=0.45, type=float)
optional.add_argument("--qual",help="The minimum quality score of SNVs to be considered in strain profiling step (default is 20).",\
    dest='qual',metavar='',default=20, type=int)
optional.add_argument("--similarity",help="The similarity cutoff of hierachical clustering in merge step (default is 0.95).",\
    dest='similarity',metavar='',default=0.95, type=float)
optional.add_argument("--elbow",help="The cutoff of elbow method while identifying strains number. \
If the loss reduction ratio is less than the cutoff, then the strains number is determined. Default is 0.24.",\
    dest='elbow',metavar='',default=0.24, type=float)
optional.add_argument("--bowtie2",help="Path to bowtie2 binary. If your platform is not Linux, you need to specify your own\
    bowtie2 binary.",dest='bowtie2',metavar='',default=scripts_dir+'../packages/bowtie2-2.3.1-legacy/bowtie2')
optional.add_argument("--bowtie2-build",help="Path to bowtie2 binary. If your platform is not Linux, you need to specify your own\
    bowtie2-build binary.",dest='bowtie2_build',metavar='',default=scripts_dir+'../packages/bowtie2-2.3.1-legacy/bowtie2-build')
optional.add_argument("--samtools",help="Path to samtools binary (default version is in the packages path). If your platform is not Linux,\
 you need to specify your own samtools binary.",dest='samtools',\
    metavar='',default=scripts_dir+'../packages/SamTools-1.3.1/samtools')
optional.add_argument("--metaphlan3",help="Path to metaphlan3 (default version is in the packages path).",dest='metaphlan3',metavar='',\
    default=scripts_dir+'../packages/metaphlan3')
optional.add_argument("--gatk",help="Path to gatk binary (default version is in the packages path).",dest='gatk',metavar='',\
    default=scripts_dir+'../packages/GATK_3.5/GenomeAnalysisTK.jar')
optional.add_argument("--picard",help="Path to picard binary (default version is in the packages path).",dest='picard',metavar='',\
    default=scripts_dir+'../packages/picard-tools-2.1.0/picard.jar')
optional.add_argument("--dbdir_V30",help="Path to marker gene database (default is in the ../db_V30 path).",dest='dbdir_V30',metavar='',\
    default=scripts_dir+'../db_V30/')
optional.add_argument("--prior",help="The file of prior knowledge of genotype frequencies in the population.\
 Not providing this is also ok.",dest='prior',metavar='',default='None')
parser._action_groups.append(optional)
args = parser.parse_args()


if len(sys.argv)==1:
    print (Usage%{'prog':sys.argv[0]})
else:
    arg_list=[args.nproc,args.species_dp,args.snp_dp,args.dbdir_V30,args.picard,args.samtools,args.bowtie2_build,args.bowtie2,'',\
        args.gatk,args.metaphlan3,args.proc,args.weight,args.lambda1,args.lambda2,args.prior,args.elbow,args.qual]
    pipeline_V30.multiproc(args.outdir,args.cfgfile,arg_list)
    merge.species_samples(args.outdir,args.cfgfile,args.similarity)
