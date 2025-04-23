#!/bin/bash
#SBATCH --time=01-00:00
#SBATCH --job-name=fasta_gtf
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-128
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/stringtie_results"
input_fasta="$INPUT_DIR/merge/ALL_merged_annotated_filter_exon.fasta"
output_fasta="$INPUT_DIR/merge/ALL_merged_annotated_filter_length.fasta"

perl -ne 'chomp; if (/>/){ print "\n$_\t"}else{ print $_}' $input_fasta | \
 perl -ne '/^(.+)\t(.+)/; if (length($2)>=200){ print "$1\t" . length($2) . "\n$2\n";}' > $output_fasta
