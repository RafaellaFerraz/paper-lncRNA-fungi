#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=CPC2
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

input_dir="/home/rsferraz/paper-lncrna-fungus/gtf_final_remove_duplicated"
input_fasta="$input_dir/ALL_merged_compare.annotated.remove_prot.fasta"
output_dir="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_stringtie_remove_duplicated_RF_with_reference/protein-coding-potential"
output="$output_dir/ALL_merged_CPC2_output.txt"

python /home/rsferraz/paper-lncrna-fungus/tools/CPC2-beta/bin/CPC2.py -i $input_fasta -o $output