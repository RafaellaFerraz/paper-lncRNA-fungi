#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=samtools
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

#conda activate samtools
INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_alignment_hisat2_remove_duplicated_RF"


for file in "$INPUT_DIR"/*.sam; do
   sample_name=$(basename "$file" | sed 's/.sam//')

   sam="$INPUT_DIR/${sample_name}.sam"
   sort_file="$INPUT_DIR/${sample_name}_sorted.bam"

   #Converted to bam
   samtools sort -@ 12 -O bam $sam -o $sort_file

   #Creating index sam
   samtools index $sort_file

done


