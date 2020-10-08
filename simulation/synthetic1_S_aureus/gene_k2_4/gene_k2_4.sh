#	2	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000737615.1_ASM73761v1_genomic.fna	0.49	/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000695215.1_ASM69521v1_genomic.fna	0.51	
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000737615.1_ASM73761v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 49 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/gene_k2_4_strain0_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/ref/GCF_000695215.1_ASM69521v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 51 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/gene_k2_4_strain1_ 
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/gene_k2_4*_1.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/gene_k2_4_1.fq
cat /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/gene_k2_4*_2.fq>/mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/gene_k2_4_2.fq
rm /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/*strain*
 gzip -f /mnt/disk2_workspace/wangshuai/00.strain/03.species/S_aureus/reads/gene_k2_4/*fq

