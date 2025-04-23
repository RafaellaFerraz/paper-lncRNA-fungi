#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=index-bowtie
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive
#SBATCH --qos=qos2

## Suport
INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/References_genome/Reference_Paracoccidioides_brasiliensis_Pb18"
GENOME="$INPUT_DIR/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.fna"
OUTPUT_DIR="$INPUT_DIR/index_bowtie2/index_bowtie2"

#Create index
bowtie2-build --threads 20 $GENOME $OUTPUT_DIR

