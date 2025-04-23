#!/bin/bash
#SBATCH --time=01-00:00
#SBATCH --job-name=abundance
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-128
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/lncrna-inference/stringtie_results"
BAM="/home/rsferraz/lncrna-inference/aligment_hisat2"
mkdir -p "$INPUT_DIR/abundance"

for file in "$INPUT_DIR"/*.gtf; do
    sample_name=$(basename "$file" | sed 's/.gtf//')
    mkdir -p $INPUT_DIR/abundance/${sample_name}

    stringtie -e -B -p 12 -G $INPUT_DIR/track/ALL_merged_track.combined.gtf \
    -A $INPUT_DIR/abundance/${sample_name}/${sample_name}_abund.tab \
    -o $INPUT_DIR/abundance/${sample_name}/${sample_name}_combined.gtf $BAM/${sample_name}_sorted.bam
done
