#	2	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000772025.1_ASM77202v1_genomic.fna	0.52	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000695215.1_ASM69521v1_genomic.fna	0.48	
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000772025.1_ASM77202v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 52 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/gene_k2_8_strain0_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000695215.1_ASM69521v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 48 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/gene_k2_8_strain1_ 
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/gene_k2_8*_1.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/gene_k2_8_1.fq
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/gene_k2_8*_2.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/gene_k2_8_2.fq
rm /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/*strain*
 gzip -f /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_8/*fq

