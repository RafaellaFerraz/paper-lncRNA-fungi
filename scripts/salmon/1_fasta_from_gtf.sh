#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=fasta_gtf
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/gtf_final_with_duplicated"
REFERENCE="/home/rsferraz/paper-lncrna-fungus/Reference_genomes/Reference_Paracoccidioides_brasiliensis_Pb18"
GENOME="$REFERENCE/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.fna"
input_gtf="$INPUT_DIR/combined_stringtie_ncbi_new_names.gtf"

#Extracting fasta files from transcripts process
gffread $input_gtf -g $GENOME -w $INPUT_DIR/combined_stringtie_ncbi_new_names.fasta -W
echo "Successful - Extract fasta files from transcripts process"

