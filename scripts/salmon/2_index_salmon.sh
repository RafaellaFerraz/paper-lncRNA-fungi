#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=index_salmon
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

module load softwares/salmon/1.9.0-pre_compiled

INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/gtf_final_with_duplicated"
fasta="$INPUT_DIR/combined_stringtie_ncbi_new_names.fasta"
index_salmon="$INPUT_DIR/index_salmon_combined_stringtie_ncbi_new_names"

salmon index -t $fasta -i $index_salmon
echo "Finished"