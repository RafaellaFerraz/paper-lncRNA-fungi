#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=PLEK
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

input_dir="/home/rsferraz/paper-lncrna-fungus/gtf_final_remove_duplicated"
input_fasta="$input_dir/ALL_merged_compare.annotated.remove_prot.fasta"
output_dir="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_stringtie_remove_duplicated_RF_with_reference/protein-coding-potential"
output="$output_dir/ALL_merged_PLEK_output.txt"

python /home/rsferraz/paper-lncrna-fungus/tools/PLEK.1.2/PLEK.py -fasta $input_fasta -out $output -thread 10