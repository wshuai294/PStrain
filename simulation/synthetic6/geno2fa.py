from Bio import SeqIO
from Bio.Seq import Seq
import os
import sys

def read_ref(ref):
    seq_dict = SeqIO.index(ref, "fasta")
    return seq_dict

def read_geno(outdir):
    # os.system('mkdir %s'%(outdir))
    seq_dict = read_ref(ref)
    alpha = []
    i = 0
    for line in open(geno, 'r'):
        fa_file = outdir+'/test_%s.fa'%(i)
        f = open(fa_file, 'w')
        line = line.strip()
        array = line.split()
        alpha.append(float(array[0]))
        reads_num = int(float(array[0])*100*20000/200)
        pre = ''
        for j in range(1, len(array), 3):
            # print (array[j], array[j+1], array[j+2])
            if array[j] != pre:
                if pre != '':
                    record.seq=mutable_seq.toseq()
                    count = SeqIO.write(record, f, "fasta")
                pre = array[j]
                record=seq_dict[array[j]]
                mutable_seq = record.seq.tomutable() 
            mutable_seq[int(float(array[j+1]))-1] = array[j+2]
            # mutable_seq[int(float(array[j+1]))-1] = 'N'
            # print (mutable_seq)
        record.seq=mutable_seq.toseq()
        
        count = SeqIO.write(record, f, "fasta")
        f.close()
        wgsim='/home/BIOINFO_TOOLS/mutation_tools/SamTools/SamTools-1.3/bin/wgsim -d 200 -e 0.0%s \
        -N %s -1 100 -2 100 -r 0 -R 0 -S 1 \
        %s %s/test_strain%s_1.fq %s/test_strain%s_2.fq'%(error, reads_num, fa_file, outdir, i, outdir, i)
        # print (wgsim)
        os.system(wgsim)
        i+=1

    order = 'cat %s/test*_1.fq>%s/final_1.fq&&cat %s/test*_2.fq>%s/final_2.fq&&rm %s/test*fq&&gzip -f %s/*fq'%(outdir,outdir,outdir,outdir,outdir,outdir)
    # print (wgsim, order)
    os.system(order)
        

def mut_test():
    test_chr = 'gi|545276179|ref|NZ_KE701962.1|:c548151-546829'
    seq_dict = read_ref(ref)
    seq = seq_dict[test_chr]
    print (seq)


ref = '/home/wangshuai/strain/04.refs/metaphlan/phlan2.fa'

# error = 0
# geno = '/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e001/gene_k2_0/gene_k2_0.geno'
# outdir = '/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e001/gene_k2_0/'
error = sys.argv[1]
geno = sys.argv[2]
outdir = sys.argv[3]

read_geno(outdir)
