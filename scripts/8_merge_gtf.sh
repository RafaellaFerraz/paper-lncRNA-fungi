#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=merge_gtf
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-256
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_stringtie_remove_duplicated_RF_with_reference"
REFERENCE="/home/rsferraz/paper-lncrna-fungus/Reference_genomes/Reference_Paracoccidioides_brasiliensis_Pb18"
ANNOTATION="$REFERENCE/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.gff"
GENOME="$REFERENCE/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.fna"

mkdir -p $INPUT_DIR/merge

#List of files
ls $INPUT_DIR/filtered_tpm/*_filter_TPM.gtf > $INPUT_DIR/tmp.txt

#OUTPUT
gtf_merge="$INPUT_DIR/merge/ALL_merged.gtf"

#Running StringTie Merge ALL transcripts from ALL experiments
stringtie --merge -m 200 -p 12 -T 1 -G $ANNOTATION -o $gtf_merge $INPUT_DIR/tmp.txt
echo "Successful - StringTie Merge ALL transcripts from ALL experiments"

#Evaluating transcriptome assembly process
gffcompare -V -r $ANNOTATION -o $INPUT_DIR/merge/ALL_merged_compare $gtf_merge
echo "Sucessful - Evaluate transcriptome assembly process"
