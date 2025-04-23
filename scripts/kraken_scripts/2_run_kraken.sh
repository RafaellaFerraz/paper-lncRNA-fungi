#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=kraken
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

DR_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/kraken_db"
INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Data"
OUTPUT_DIR="$DR_DIR/descontamination_organisms"

mkdir -p $OUTPUT_DIR

valid_samples=("003L0001" "003L0002" "003L0003" 
                "008L0001" "008L0002" "008L0003")


for sample_name in "${valid_samples[@]}"; do

    forward="$INPUT_DIR/Unknown_CF760-${sample_name}_good_1.fq.gz"
    reverse="$INPUT_DIR/Unknown_CF760-${sample_name}_good_2.fq.gz"
    report_kraken="$OUTPUT_DIR/CF760-${sample_name}_report_kraken2.txt"
    output_kraken="$OUTPUT_DIR/CF760-${sample_name}_output_kraken2.txt"
    classified="$OUTPUT_DIR/CF760-${sample_name}_classified#.fq"
    unclassified="$OUTPUT_DIR/CF760-${sample_name}_unclassified#.fq"

    if [[ -f "$forward" && -f "$reverse" ]]; then
            echo "Run kraken2 for CF760-${sample_name}..."
            
            kraken2 --db /home/rsferraz/scratch/paper_lncRNA_fungi/kraken_db/fungal_kraken2_db \
            --threads 15 \
            --gzip-compressed \
            --report $report_kraken \
            --output $output_kraken \
            --use-names \
            --classified-out $classified \
            --unclassified-out $unclassified \
            --paired $forward $reverse
        
            echo "Files processed: $out_forward e $out_reverse"
        else
            echo "Input files not found for $sample_name. Skiping..."
        fi
done