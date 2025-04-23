
INPUT_DIR="/home/rsferraz/paper-lncrna-fungus/Outputs/pbs_aligment_hisat2"

echo -e "File\tTotal\tPrimary\tSecondary\tSupplementary\tDuplicates\tPrimaryDuplicates\tMapped\tPrimaryMapped\tPairedInSequencing\tRead1\tRead2\tProperlyPaired\tWithMateMapped\tSingletons\tWithMateMappedToDifferentChr\tWithMateMappedToDifferentChrMapQ5" > $INPUT_DIR/flagstat_results_summary.txt

for file in "$INPUT_DIR"/*.bam; do
    # Run samtools flagstat and capture the output
    result=$(samtools flagstat "$file")
    
    # Check if the result is non-empty (if samtools flagstat ran correctly)
    if [ -n "$result" ]; then
        # Extract each value using grep and awk
        total=$(echo "$result" | grep -P "in total" | awk '{print $1}')
        primary=$(echo "$result" | grep -P "primary" | awk '{print $1}')
        secondary=$(echo "$result" | grep -P "secondary" | awk '{print $1}')
        supplementary=$(echo "$result" | grep -P "supplementary" | awk '{print $1}')
        duplicates=$(echo "$result" | grep -P "duplicates" | awk '{print $1}')
        primary_duplicates=$(echo "$result" | grep -P "primary duplicates" | awk '{print $1}')
        mapped=$(echo "$result" | grep -P "mapped" | awk '{print $1}')
        primary_mapped=$(echo "$result" | grep -P "primary mapped" | awk '{print $1}')
        paired_in_sequencing=$(echo "$result" | grep -P "paired in sequencing" | awk '{print $1}')
        read1=$(echo "$result" | grep -P "read1" | awk '{print $1}')
        read2=$(echo "$result" | grep -P "read2" | awk '{print $1}')
        properly_paired=$(echo "$result" | grep -P "properly paired" | awk '{print $1}')
        mate_mapped=$(echo "$result" | grep -P "with itself and mate mapped" | awk '{print $1}')
        singletons=$(echo "$result" | grep -P "singletons" | awk '{print $1}')
        mate_diff_chr=$(echo "$result" | grep -P "with mate mapped to a different chr" | awk '{print $1}')
        mate_diff_chr_mapq5=$(echo "$result" | grep -P "with mate mapped to a different chr \(mapQ>=5\)" | awk '{print $1}')
        
        # Write the results to the output file
        echo -e "$file\t$total\t$primary\t$secondary\t$supplementary\t$duplicates\t$primary_duplicates\t$mapped\t$primary_mapped\t$paired_in_sequencing\t$read1\t$read2\t$properly_paired\t$mate_mapped\t$singletons\t$mate_diff_chr\t$mate_diff_chr_mapq5" >> $INPUT_DIR/flagstat_results_summary.txt
    else
        echo "Error: samtools flagstat did not produce output for file $file"
    fi
done