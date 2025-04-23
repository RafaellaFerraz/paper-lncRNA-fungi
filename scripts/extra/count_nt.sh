#!/bin/bash

input_dir="/home/rsferraz/scratch/paper_lncRNA_fungi/Outputs/pbs_stringtie_remove_duplicated_RF_with_reference/merge"
fasta="$input_dir/ALL_merged_compare.annotated.remove_prot.fasta"
out="$input_dir/output_nts_por_transcrito.txt"

awk '
/^>/ {
    if (seqname != "") {
        print seqname, length(seq)
    }
    match($0, /^>([^\s]+)/, arr)
    seqname = arr[1]
    seq = ""
    next
}
{
    seq = seq $0
}
END {
    if (seqname != "") {
        print seqname, length(seq)
    }
}
' $fasta > $out
