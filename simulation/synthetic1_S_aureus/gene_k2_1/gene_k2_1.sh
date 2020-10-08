#	2	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000462955.1_ASM46295v1_genomic.fna	0.53	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000296595.1_ASM29659v1_genomic.fna	0.47	
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000462955.1_ASM46295v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 53 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/gene_k2_1_strain0_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000296595.1_ASM29659v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 47 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/gene_k2_1_strain1_ 
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/gene_k2_1*_1.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/gene_k2_1_1.fq
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/gene_k2_1*_2.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/gene_k2_1_2.fq
rm /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/*strain*
 gzip -f /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_1/*fq

