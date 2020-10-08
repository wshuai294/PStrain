#	2	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000737615.1_ASM73761v1_genomic.fna	0.75	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000009005.1_ASM900v1_genomic.fna	0.25	
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000737615.1_ASM73761v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 75 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/gene_k2_6_strain0_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000009005.1_ASM900v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 25 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/gene_k2_6_strain1_ 
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/gene_k2_6*_1.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/gene_k2_6_1.fq
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/gene_k2_6*_2.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/gene_k2_6_2.fq
rm /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/*strain*
 gzip -f /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_6/*fq

