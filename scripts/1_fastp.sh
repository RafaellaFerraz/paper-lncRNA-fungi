#!/bin/bash
#SBATCH --time=01-00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-128
#SBATCH --exclusive


# Diretório contendo os arquivos de entrada
INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/RawData/together_organisms"
OUTPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/trimagem_together_organisms"
LOG_DIR="$OUTPUT_DIR/logs"
adapter="/home/rsferraz/paper-lncrna-fungus/TruSeq3-PE-2.fa"

# Criar diretório de saída e logs, se não existirem
mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

# Loop para processar os arquivos
for file in "$INPUT_DIR"/*1.fq.gz; do
    # Extrai o nome base da amostra
    sample_name=$(basename "$file" | sed -E 's/^Unknown_([A-Z0-9-]+)_[12]\.fq\.gz$/\1/')
    # Define os arquivos de entrada e saída
    forward="$INPUT_DIR/Unknown_${sample_name}_1.fq.gz"
    reverse="$INPUT_DIR/Unknown_${sample_name}_2.fq.gz"
    out_forward="$OUTPUT_DIR/${sample_name}_1.fq.gz"
    out_reverse="$OUTPUT_DIR/${sample_name}_2.fq.gz"
    json_report="$LOG_DIR/${sample_name}_fastp.json"
    html_report="$LOG_DIR/${sample_name}_fastp.html"

    # Executa fastp
    fastp \
        -i "$forward" -I "$reverse" \
        -o "$out_forward" -O "$out_reverse" \
        --qualified_quality_phred 20 --thread 8 \
        --json "$json_report" --html "$html_report" \
        --detect_adapter_for_pe --dedup --overrepresentation_analysis \
	    --trim_poly_g --trim_poly_x --poly_x_min_len 5 --poly_g_min_len 5 \
        --adapter_fasta $adapter

done

echo "Processamento concluído!"
