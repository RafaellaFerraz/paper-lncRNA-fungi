#!/bin/bash
#SBATCH --time=01-00:00
#SBATCH --job-name=hisat2
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_stringtie_remove_duplicated_RF_with_reference"


for file in "$INPUT_DIR"/*.gtf; do
    sample_name=$(basename "$file" | sed 's/.gtf//')

    #Create temporary file
    valid_ids=$(mktemp)

    #Extract transcript_id from transcripts with TPM >= 1
    awk '$3 == "transcript" && match($0, /transcript_id "([^"]+)".*TPM "([0-9.]+)"/, a) { if (a[2] >= 0.1) print a[1]; }' "$file" > "$valid_ids"

    #Filter GTF and keep transcripts and yours exons
    awk -v valid_ids="$valid_ids" '
    BEGIN {
        while ((getline < valid_ids) > 0) valid[$1] = 1;
        close(valid_ids);
    }
    $3 == "transcript" && match($0, /transcript_id "([^"]+)"/, a) { keep = (a[1] in valid); }
    keep || ($3 == "exon" && match($0, /transcript_id "([^"]+)"/, a) && (a[1] in valid))' "$file" > $INPUT_DIR/${sample_name}_filter_TPM.gtf
    #Remove temporary file
    rm -f "$valid_ids"

    echo "Concluded! Output in $INPUT_DIR/${sample_name}_filter_TPM.gtf"
done
