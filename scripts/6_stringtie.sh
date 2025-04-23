#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=stringtie
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive


INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_alignment_hisat2_remove_duplicated_RF"
OUTPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_stringtie_remove_duplicated_RF_with_reference"
REFERENCE="/home/rsferraz/paper-lncrna-fungus/Reference_genomes/Reference_Paracoccidioides_brasiliensis_Pb18"
ANNOTATION="$REFERENCE/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.gff"

mkdir -p $OUTPUT_DIR

valid_samples=("CF760-008L0007" "CF760-008L0008" "CF760-008L0009" 
                "CF760-008L0010" "CF760-008L0011" "CF760-008L0012")

for sample_name in "${valid_samples[@]}"; do
    #input
    sort_file="$INPUT_DIR/${sample_name}_sorted.bam"
    #output
    gtf_output="$OUTPUT_DIR/${sample_name}.gtf"

    if [[ -f "$sort_file" ]]; then
        echo "Run stringtie for ${sample_name}..."

        #StringTie assembly process
        stringtie -j 3 -c 3 --rf -p 12 -v -m 200 -G $ANNOTATION -o $gtf_output $sort_file
        #stringtie -j 3 -c 3 --rf -p 12 -v -m 200 -o $gtf_output $sort_file
       
        echo "Files processed: $sort_file"
    else
        echo "Input files not found for $sample_name. Skipping..."
    fi

done


