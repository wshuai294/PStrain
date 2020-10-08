#	2	/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000014845.1_ASM1484v1_genomic.fna	0.333333	/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000026265.1_ASM2626v1_genomic.fna	0.666667	
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000014845.1_ASM1484v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 1 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/gene_k2_6_strain0_ 
/home/wangshuai/softwares/art_bin_MountRainier/art_illumina -i /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/general_strains/GCA_000026265.1_ASM2626v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 2 --noALN -o /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/gene_k2_6_strain1_ 
cat /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/gene_k2_6*_1.fq>/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/gene_k2_6_1.fq
cat /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/gene_k2_6*_2.fq>/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/gene_k2_6_2.fq
rm /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/*strain*
 gzip -f /mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/*fq
prefix=/mnt/disk2_workspace/wangshuai/00.strain/01.real_strains/sample3/gene_k2_6/gene_k2_6

    #Calling and Mapping
    bowtie2 -x /home/wangshuai/strain/04.refs/genes/ecoli_gene -1 ${prefix}_1.fq.gz -2 ${prefix}_2.fq.gz -S $prefix.sam    
    #rm ${prefix}_*.fq.gz
    cat $prefix.sam | grep -v "XS:i:"|samtools view -bS -F 4|samtools sort -o $prefix.sorted.bam
    rm $prefix.sam
    java -jar /home/BIOINFO_TOOLS/alignment_tools/Picard/picard-tools-2.1.0/picard.jar AddOrReplaceReadGroups I=$prefix.sorted.bam O=$prefix.header.bam LB=whatever PL=illumina PU=whatever SM=whatever 
    rm $prefix.sorted.bam
    samtools index $prefix.header.bam
    java -Xmx5g -jar /home/BIOINFO_TOOLS/mutation_tools/GATK/GATK_3.5/GenomeAnalysisTK.jar \
    -T HaplotypeCaller -R /home/wangshuai/strain/04.refs/genes/ecoli_gene.fa -allowPotentiallyMisencodedQuals \
    -I $prefix.header.bam -o $prefix.vcf.gz
    gzip -d -f $prefix.vcf.gz
    #python3 /home/wangshuai/strain/00.simulation/05.samples/03.real_strain/code/snp_filter.py $prefix.vcf >$prefix.filter.vcf
    #~/softwares/HapCUT2/build/extractHAIRS --bam $prefix.header.bam --VCF $prefix.vcf --out $prefix.conn

    
