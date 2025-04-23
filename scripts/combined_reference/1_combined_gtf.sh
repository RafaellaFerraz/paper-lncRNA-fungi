#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=combined
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive


input_gtf="/home/rsferraz/paper-lncrna-fungus/gtf_final/combined_stringtie_reference.gtf"
REFERENCE="/home/rsferraz/paper-lncrna-fungus/Reference_genomes/Reference_Paracoccidioides_brasiliensis_Pb18"
GENOME="$REFERENCE/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.fna"
INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/gtf_final"

#Extracting fasta files from transcripts process
gffread $input_gtf -g $GENOME -w $INPUT_DIR/combined_stringtie_reference.fasta -W
echo "Successful - Extract fasta files from transcripts process"