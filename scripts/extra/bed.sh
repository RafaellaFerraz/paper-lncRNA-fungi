#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=bed
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive

anotacao_gtf="/home/rsferraz/scratch/paper_lncRNA_fungi/References_genome/Reference_Paracoccidioides_brasiliensis_Pb18/GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.gtf"
out_dir="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/bed"
input="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/pbs_alignment_hisat2_remove_duplicated_RF/CF760-008L0012_sorted.bam"

#bedtools sort -i "$anotacao_gtf" | awk '$3 == "exon"' | awk '{
    # Para cada linha, buscamos o gene_id na coluna 10
#    gene_id="";
#    match($10, /"([^"]+)"/, arr);  # Extrair o gene_id entre aspas na coluna 10
#    if (arr[1] != "") {
#        gene_id = arr[1];
#    }
#    if (gene_id != "") {
#        print $1"\t"$4-1"\t"$5"\t"gene_id"\t.\t"$7;
#    }
#}' > "$out_dir/Paracocci_br_Pb18.bed"


infer_experiment.py -r "$out_dir/Paracocci_br_Pb18.bed" -i $input