#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=remove_dedup
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Data"
OUTPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Outputs/remove-duplicated"

mkdir -p $OUTPUT_DIR

valid_samples=("008L0001" "008L0002" "008L0003" 
                "008L0004" "008L0005" "008L0006"
                "008L0007" "008L0008" "008L0009" 
                "008L0010" "008L0011" "008L0012")

for sample_name in "${valid_samples[@]}"; do
    # Arquivos de entrada
    forward="$INPUT_DIR/Unknown_CF760-${sample_name}_good_1.fq.gz"
    reverse="$INPUT_DIR/Unknown_CF760-${sample_name}_good_2.fq.gz"
    # Arquivos de saída
    out_forward="$OUTPUT_DIR/CF760_${sample_name}_clean_dedup_1.fq.gz"
    out_reverse="$OUTPUT_DIR/CF760_${sample_name}_clean_dedup_2.fq.gz"

    # Verifica se os arquivos de entrada existem
    if [[ -f "$forward" && -f "$reverse" ]]; then
        echo "Removing duplicates for $sample_name..."
        
        seqkit rmdup --by-seq --ignore-case -o "$out_forward" "$forward"
        seqkit rmdup --by-seq --ignore-case -o "$out_reverse" "$reverse"
    
        echo "Files processed: $out_forward e $out_reverse"
    else
        echo "Input files not found for $sample_name. Skiping..."
    fi
done