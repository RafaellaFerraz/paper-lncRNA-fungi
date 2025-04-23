#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=dedup-fastp
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive


INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Data"
OUTPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/dedup_only_fastp"
mkdir -p $OUTPUT_DIR

valid_samples=("008L0004" "008L0005" "008L0006"
                "008L0007" "008L0008" "008L0009" 
                "008L0010" "008L0011" "008L0012")

for sample_name in "${valid_samples[@]}"; do
    # Arquivos de entrada
    forward="$INPUT_DIR/Unknown_CF760-${sample_name}_good_1.fq.gz"
    reverse="$INPUT_DIR/Unknown_CF760-${sample_name}_good_2.fq.gz"

    out_forward="$OUTPUT_DIR/CF760-${sample_name}_dedup_1.fq.gz"
    out_reverse="$OUTPUT_DIR/CF760-${sample_name}_dedup_2.fq.gz"
    json_report="$LOG_DIR/CF760-${sample_name}_fastp.json"
    html_report="$LOG_DIR/CF760-${sample_name}_fastp.html"

    fastp --thread 8 \
    --disable_quality_filtering \
    --disable_length_filtering \
    --disable_adapter_trimming \
    --json "$json_report" --html "$html_report" \
    --dedup -i "$forward" -I "$reverse" \
    -o "$out_forward" -O "$out_reverse"
    

done