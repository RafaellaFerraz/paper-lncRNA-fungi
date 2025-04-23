#!/bin/bash
#SBATCH --time=02-00:00
#SBATCH --job-name=fastx
#SBATCH --mail-user=rafaella.ferraz.047@ufrn.edu.br
#SBATCH --mail-type=ALL
#SBATCH --partition=intel-512
#SBATCH --exclusive


INPUT_DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/dedup-fastp-fastx"

valid_samples=("008L0004" "008L0005" "008L0006"
                "008L0007" "008L0008" "008L0009" 
                "008L0010" "008L0011" "008L0012")

for sample_name in "${valid_samples[@]}"; do
    merge_file="$INPUT_DIR/CF760-${sample_name}_merge.fastq"
    collapse_file="$INPUT_DIR/CF760-${sample_name}_collapse.fastq"

    if [[ -f "$merge_file" ]]; then
        echo "Processing $merge_file..."
        fastx_collapser -i "$merge_file" -o "$collapse_file" -v
    else
        echo "File $merge_file not found, skipping..."
    fi
done

#/var/tmp/slurmd.spool/job1130770/slurm_script: line 16: 3698454 Segmentation fault      (core dumped) fastx_collapser -i "$merge_file" -o "$collapse_file" -v