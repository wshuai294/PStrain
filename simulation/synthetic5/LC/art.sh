art_illumina -i GCF_000003925.1_ASM392v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 50 --noALN -o GCF_000003925.1_ASM392v1_genomic.fna.gz_part
art_illumina -i GCF_000005825.2_ASM582v2_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 50 --noALN -o GCF_000005825.2_ASM582v2_genomic.fna.gz_part
art_illumina -i GCF_000006605.1_ASM660v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 50 --noALN -o GCF_000006605.1_ASM660v1_genomic.fna.gz_part
art_illumina -i GCF_000008025.1_ASM802v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 50 --noALN -o GCF_000008025.1_ASM802v1_genomic.fna.gz_part
art_illumina -i GCF_000013145.1_ASM1314v1_genomic.fna -l 100 -m 350 -s 50 -ss HS20 --fcov 50 --noALN -o GCF_000013145.1_ASM1314v1_genomic.fna.gz_part
cat *part1.fq mx1_1.fq
cat *part2.fq mx1_2.fq
rm *part*
gzip mx1_1.fq
gzip mx1_2.fq
