#error=1
#geno=/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e001/gene_k2_0/gene_k2_0.geno
#outdir=/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e001/gene_k2_0/
for error in {0,1,2,3,4,5}
do
for k in {2..4}
do
for i in {0..49}
do
sample=gene_k${k}_${i}
        prefix="/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e00$error/$sample/$sample" 
        path="/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e00$error/$sample/" 
        mkdir $path
        cd $path
        /home/wangshuai/softwares/GemSIM_v1.6/GemHaps.py -r /home/wangshuai/strain/04.refs/metaphlan/phlan2.fa -g '1,600' 
        /home/wangshuai/softwares/Python-3.7.0/bin/python3 /home/wangshuai/strain/00.simulation/05.samples/00.sim/01.basic_codes/geno.py $k $prefix.geno $prefix.beta $path/phlan2.txt
geno=/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e00$error/$sample/$sample.geno
outdir=/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/e00$error/$sample/
/home/wangshuai/softwares/Python-3.7.0/bin/python3  /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/new_reads_error/geno2fa.py $error $geno $outdir 
done
done
done
