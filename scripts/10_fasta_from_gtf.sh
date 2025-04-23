#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=fasta_gtf
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/gtf_final_remove_duplicated"
REFERENCE="/home/rsferraz/paper-lncrna-fungus/Reference_genomes/Reference_Paracoccidioides_brasiliensis_Pb18"
GENOME="$REFERENCE/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.fna"
input_gtf="$INPUT_DIR/ALL_merged_compare.annotated.remove_prot.gtf"

#Extracting fasta files from transcripts process
gffread -W -F -w $INPUT_DIR/ALL_merged_compare.annotated.remove_prot.fasta -g $GENOME $input_gtf
echo "Successful - Extract fasta files from transcripts process"

#Joining transcripts names - easier identification
perl /home/rsferraz/lncrna-inference/tool/mstrg_prep.pl $input_gtf >  "$INPUT_DIR/ALL_merged_compare.annotated.remove_prot_prep.gtf"
echo "Successful - Join transcripts names - easier identification"