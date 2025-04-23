#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=salmon
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

module load softwares/salmon/1.9.0-pre_compiled

index_salmon="/home/rsferraz/paper-lncrna-fungus/gtf_final_with_duplicated/index_salmon_combined_stringtie_ncbi_new_names"
INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Data"
OUTPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_with_duplicated/pbs_salmon_quant_combined_stringtie_ncbi"

mkdir -p $OUTPUT_DIR

valid_samples=("CF760-008L0007" "CF760-008L0008" "CF760-008L0009" 
                "CF760-008L0010" "CF760-008L0011" "CF760-008L0012")

for sample_name in "${valid_samples[@]}"; do
    #Input files
    #forward="$INPUT_DIR/${sample_name}_dedup_1.fq.gz"
    #reverse="$INPUT_DIR/${sample_name}_dedup_2.fq.gz"
    forward="$INPUT_DIR/Unknown_${sample_name}_good_1.fq.gz"
    reverse="$INPUT_DIR/Unknown_${sample_name}_good_2.fq.gz"

    #Output files
    out_files="$OUTPUT_DIR/${sample_name}"

    if [[ -f "$forward" ]] && [[ -f "$reverse" ]]; then
        echo "Run SAlmon for ${sample_name}..."
        
        salmon quant \
        -i $index_salmon -l A \
        -1 $forward -2 $reverse -o $out_files

    else
        echo "Input files not found for $sample_name. Skipping..."
    fi
done



