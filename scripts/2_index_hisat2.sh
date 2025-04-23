#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=index-hisat
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-128
#SBATCH --exclusive

## Suport
INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Reference_genomes/Reference_Paracoccidioides_brasiliensis_Pb18"
GTF="$INPUT_DIR/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.gtf"
GENOME="$INPUT_DIR/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.fna"
OUTPUT_DIR="$INPUT_DIR/index_hisat2/index_hisat2"

mkdir -p $INPUT_DIR/index_hisat2

# Extract splice sites
hisat2_extract_splice_sites.py $GTF > $INPUT_DIR/splice_sites.txt

#Extract exons
hisat2_extract_exons.py $GTF > $INPUT_DIR/exons.txt

#Create index
hisat2-build --ss $INPUT_DIR/splice_sites.txt --exon $INPUT_DIR/exons.txt $GENOME $OUTPUT_DIR -p 20

