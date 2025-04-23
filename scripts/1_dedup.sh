#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=clumpify
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive


# Diretório contendo os arquivos de entrada
INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Data"
OUTPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/dedup-bbtools"
mkdir -p $OUTPUT_DIR

valid_samples=("008L0004" "008L0005" "008L0006"
                "008L0007" "008L0008" "008L0009" 
                "008L0010" "008L0011" "008L0012")

for sample_name in "${valid_samples[@]}"; do

    # Define os arquivos de entrada e saída
    forward="$INPUT_DIR/Unknown_CF760-${sample_name}_good_1.fq.gz"
    reverse="$INPUT_DIR/Unknown_CF760-${sample_name}_good_2.fq.gz"

    out_forward="$OUTPUT_DIR/CF760-${sample_name}_dedup_1.fq.gz"
    out_reverse="$OUTPUT_DIR/CF760-${sample_name}_dedup_2.fq.gz"

    # Executa fastp
    clumpify.sh \
    in1=$forward in2=$reverse \
    out1=$out_forward out2=$out_reverse \
    dedupe=t optical=t spany=t adjacent=t

done