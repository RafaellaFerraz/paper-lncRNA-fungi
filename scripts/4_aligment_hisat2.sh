#!/bin/bash
#SBATCH --time=2-00:00
#SBATCH --job-name=hisat2
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive
#SBATCH --qos=qos2

INDEX="/home/rsferraz/paper-lncrna-fungus/Reference_genomes/Reference_Paracoccidioides_brasiliensis_Pb18/index_hisat2/index_hisat2"
INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/dedup-bbtools"
OUTPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_alignment_hisat2_remove_duplicated_RF"
mkdir -p $OUTPUT_DIR

valid_samples=("CF760-008L0007" "CF760-008L0008" "CF760-008L0009" 
                "CF760-008L0010" "CF760-008L0011" "CF760-008L0012")

for sample_name in "${valid_samples[@]}"; do
    #Input files
    forward="$INPUT_DIR/${sample_name}_dedup_1.fq.gz"
    reverse="$INPUT_DIR/${sample_name}_dedup_2.fq.gz"
    #forward="$INPUT_DIR/Unknown_${sample_name}_good_1.fq.gz"
    #reverse="$INPUT_DIR/Unknown_${sample_name}_good_2.fq.gz"

    #Output files
    splice="$OUTPUT_DIR/${sample_name}_splice_sites.out"
    sam="$OUTPUT_DIR/${sample_name}.sam"
    unpair_unligned="$OUTPUT_DIR/${sample_name}_unpair_unligned.fq.gz"
    unpair_aligned="$OUTPUT_DIR/${sample_name}_unpair_aligned.fq.gz"
    summary="$OUTPUT_DIR/${sample_name}_summary.out"
    pair_unligned="$OUTPUT_DIR/${sample_name}_pair_unligned.fq.gz"
    pair_aligned="$OUTPUT_DIR/${sample_name}_pair_aligned.fq.gz"

    if [[ -f "$forward" ]] && [[ -f "$reverse" ]]; then
        echo "Run Hisat2 for ${sample_name}..."
        #Run alignment with hisat2
        
        hisat2 \
        -p 15 --dta \
        --rna-strandness RF \
        --no-mixed --no-discordant \
        --novel-splicesite-outfile $splice -x $INDEX \
        -1 $forward -2 $reverse -S $sam --un-gz $unpair_unligned --al-gz $unpair_aligned \
        --un-conc-gz $pair_unligned --al-conc-gz $pair_aligned \
        --summary-file $summary

    else
        echo "Input files not found for $sample_name. Skipping..."
    fi
done