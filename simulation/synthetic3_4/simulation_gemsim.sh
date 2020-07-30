for k in {19..30}
do
    for i in {0..49}
        do
        echo $k $i
        sample=gene_k${k}_${i}
        prefix="/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/gemsim/strain_num/$sample/$sample" 
        path="/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/gemsim/strain_num/$sample/" 
    
        #generate snps refs
        mkdir $path
        cd /home/wangshuai/strain/04.refs/metaphlan/
        /home/wangshuai/softwares/GemSIM_v1.6/GemReads.py  -r phlan2.fa -n 5000 -g $prefix.geno -p -l 100 -m /home/wangshuai/softwares/GemSIM_v1.6/models/ill100v5_p.gzip -q 64 -u d -o $prefix
        gzip -f $prefix*fastq
        done
done
    
