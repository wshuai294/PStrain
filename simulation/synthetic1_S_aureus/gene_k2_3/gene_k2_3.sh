#	2	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_001019035.1_ASM101903v1_genomic.fna	0.25	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000284535.1_ASM28453v1_genomic.fna	0.75	
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_001019035.1_ASM101903v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 25 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/gene_k2_3_strain0_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000284535.1_ASM28453v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 75 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/gene_k2_3_strain1_ 
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/gene_k2_3*_1.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/gene_k2_3_1.fq
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/gene_k2_3*_2.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/gene_k2_3_2.fq
rm /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/*strain*
 gzip -f /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_3/*fq

