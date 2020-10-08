for k in {2..4}
do
    for i in {0..49}
        do
        echo $k $i
        sample=gene_k${k}_${i}
        prefix="/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/length_gemsim/len75/$sample/$sample" 
        path="/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/length_gemsim/len75/$sample/" 
    
        #generate snps refs
        mkdir $path
        cd $path
        /home/wangshuai/softwares/GemSIM_v1.6/GemHaps.py -r /home/wangshuai/strain/04.refs/metaphlan/phlan2.fa -g '1,600' 
        #Simulating step
        /home/wangshuai/softwares/Python-3.7.0/bin/python3 /home/wangshuai/strain/00.simulation/05.samples/00.sim/01.basic_codes/geno.py $k $prefix.geno $prefix.beta $path/phlan2.txt
        cd /home/wangshuai/strain/04.refs/metaphlan/
        /home/wangshuai/softwares/GemSIM_v1.6/GemReads.py  -r phlan2.fa -n 6666 -g $prefix.geno -p -l 75 -m /home/wangshuai/softwares/GemSIM_v1.6/models/ill100v5_p.gzip -q 64 -u d -o $prefix
        gzip -f $prefix*fastq
        done
done
    
