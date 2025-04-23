#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=nucleot-prot
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive


dir="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/results_remove_duplicated/pbs_stringtie_remove_duplicated_RF_with_reference"
input_fasta="/home/rsferraz/paper-lncrna-fungus/gtf_final_remove_duplicated/ALL_merged_compare.annotated.remove_prot.fasta"
output_dir="$dir/protein-ORFs"
Pfam_A="/home/rsferraz/paper-lncrna-fungus/tools/pfam_database/Pfam-A.hmm"
pfam_domtblout="$output_dir/ALL_merged_compare.annotated.remove_prot.fasta.transdecoder_dir/ALL_merged_compare.annotated.remove_prot_pfam_hits_longest_orfs.txt"

TransDecoder.LongOrfs -t $input_fasta --output_dir $output_dir

#wget https://ftp.ebi.ac.uk/pub/databases/Pfam/current_release/Pfam-A.hmm.gz
#gunzip Pfam-A.hmm.gz

hmmpress $Pfam_A
hmmsearch --cpu 12 -E 1e-10 --domtblout $pfam_domtblout $Pfam_A $output_dir/ALL_merged_compare.annotated.remove_prot.fasta.transdecoder_dir/longest_orfs.pep

#TransDecoder.Predict -t $input_fasta --retain_pfam_hits $pfam_domtblout --output_dir $output_dir
