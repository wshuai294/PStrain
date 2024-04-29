import re
import sys

def extract_sequence_info(file_path, output_file):

    """
    get gene ID and the corresponding species name

    metaphlan3 database  example:
    >1455__A0A0C2TZA5__A3781_04875 UniRef90_A0A0C2TZA5;k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales|f__Bacillaceae|g__Bacillus|s__Bacillus_badius;GCA_001632185
    ATGACCAAATTCAACGGACTGAATGGAGAGATTGATATAAAGAGGGCATTCATTTTAGCAGCTTTTACGCTTACTTTGGCAGCAGCCTATTATTTCATCTCGAAAGATCGCACGGAGAGTGCCGGTTCCAAAGAATTGGTTGTGATTTCCGAGACAGATGCGGAAGATATCG
    """
    with open(file_path, "r") as file:
        with open(output_file, "w") as output:
            for line in file:
                if line.startswith(">"):
                    gene_id = line[1:].strip().split()[0]
                    match = re.search(r"s__([^;]+)", line)
                    if match:
                        species_name = match.group(1)
                        output.write(f"{gene_id}\t{species_name}\n")


if __name__ == "__main__":
    file_path = sys.argv[1]  ## metaphlan3 ref  
    output_file = sys.argv[2]

    extract_sequence_info(file_path, output_file)
