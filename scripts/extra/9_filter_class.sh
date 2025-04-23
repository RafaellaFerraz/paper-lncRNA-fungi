#!/bin/bash
#SBATCH --time=01-00:00
#SBATCH --job-name=class_filter
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-128
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/stringtie_results/merge"
input_gtf="$INPUT_DIR/ALL_merged.annotated.gtf"
output_gtf="$INPUT_DIR/ALL_merged_annotated_filter_class.gtf"

awk '
BEGIN { OFS="\t" }
{
    # Para transcritos, verifica se possuem class_code "i", "j", "o", "u" ou "x"
    if ($3 == "transcript" && match($0, /class_code "(i|j|o|u|x)"/)) {
        print $0  # Mantém o transcrito no arquivo de saída
        match($0, /transcript_id "([^"]+)"/, tid)  # Captura transcript_id
        if (tid[1] != "") {
            transcript_ids[tid[1]] = 1  # Armazena transcript_id no array
        }
    } 
    # Para exons, verifica se o transcript_id está na lista dos aceitos
    else if ($3 == "exon") {
        match($0, /transcript_id "([^"]+)"/, tid)  # Captura transcript_id
        if (tid[1] in transcript_ids) {
            print $0  # Mantém o exon se pertence a um transcrito aceito
        }
    }
}' "$input_gtf" > "$output_gtf"

echo "Filtragem concluída. Resultados salvos em $output_gtf."

