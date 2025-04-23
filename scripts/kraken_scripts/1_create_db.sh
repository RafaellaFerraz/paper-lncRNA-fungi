#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=create_db
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-128
#SBATCH --exclusive

DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/kraken2_db"
DBNAME="$DIR/fungal_kraken2_db"

kraken2-build --download-taxonomy --db fungal_kraken2_db --threads 12
kraken2-build --download-library fungi --db fungal_kraken2_db --threads 12
kraken2-build --build --db fungal_kraken2_db --threads 12