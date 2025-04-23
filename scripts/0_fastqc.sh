#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-256
#SBATCH --exclusive

# Directories
dir_input="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/dedup-bbtools"
dir_output="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/fastqc_pos_remove_duplicated"

# Create Directories of output
mkdir -p $dir_output

# Run Fastqc in all samples
fastqc $dir_input/*.fq.gz -t 6 --outdir $dir_output 

