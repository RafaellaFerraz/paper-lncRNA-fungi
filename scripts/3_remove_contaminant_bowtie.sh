#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=contaminant_remove
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --mem=250G

INDEX="/home/rsferraz/scratch/paper_lncRNA_fungi/References_genome/Reference_Homo_sapiens/index_bowtie2/index_bowtie2"
INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Data"

OUTPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/Data_remove_organism/A549_Homo_sapiens_bowtie"
mkdir -p $OUTPUT_DIR

valid_samples=("003L0001" "003L0002" "003L0003")

#Run
for file in "$INPUT_DIR"/*_1.fq.gz; do
    # Extrai o nome base da amostra
    sample_name=$(basename "$file" | sed -E 's/^Unknown_(CF760-[0-9A-Z]+)_good_1.fq.gz/\1/')

    # Process valid samples
    for valid_sample in "${valid_samples[@]}"; do
        if [[ "$file" == *"$valid_sample"* ]]; then

            #Input files
            forward="$INPUT_DIR/Unknown_${sample_name}_good_1.fq.gz"
            reverse="$INPUT_DIR/Unknown_${sample_name}_good_2.fq.gz"

            #Output files
            sam="$OUTPUT_DIR/${sample_name}.sam"
            pair_fail_align="$OUTPUT_DIR/${sample_name}_clean.fq.gz"

            #Run alignment with hisat2
            bowtie2 \
            -x $INDEX \
            -1 $forward -2 $reverse -p 20 \
            -S $sam --un-conc-gz $pair_fail_align 
     	    break
        fi
    done
done
