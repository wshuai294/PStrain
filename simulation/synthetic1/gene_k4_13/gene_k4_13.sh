#	4	/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000014845.1_ASM1484v1_genomic.fna	0.13	/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCF_000013305.1_ASM1330v1_genomic.fna	0.14	/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000007445.1_ASM744v1_genomic.fna	0.24	/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000010385.1_ASM1038v1_genomic.fna	0.49	
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000014845.1_ASM1484v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 13.0 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13_strain0_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCF_000013305.1_ASM1330v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 14.0 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13_strain1_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000007445.1_ASM744v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 24.0 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13_strain2_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000010385.1_ASM1038v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 49.0 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13_strain3_ 
cat /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13*_1.fq>/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13_1.fq
cat /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13*_2.fq>/mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/gene_k4_13_2.fq
rm /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/*strain*
 gzip -f /mnt/disk2_workspace/wangshuai/00.strain/18.revision_PStrain/DATA/syn1/gene_k4_13/*fq
