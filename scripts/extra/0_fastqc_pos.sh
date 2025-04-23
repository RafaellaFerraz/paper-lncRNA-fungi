#!/bin/bash
#SBATCH --time=01-00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-128
#SBATCH --exclusive

# Directories
dir_input="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/trimagem_together_organisms"
dir_output="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/fastqc-pos-together-organisms"

# Create Directories of output
mkdir -p $dir_output

# Run Fastqc in all samples
fastqc $dir_input/*.fq.gz --outdir $dir_output -t 6

