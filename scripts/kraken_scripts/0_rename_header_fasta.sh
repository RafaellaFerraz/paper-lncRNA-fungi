

DIR="/home/rsferraz/scratch/paper_lncRNA_fungi/References_genome/Reference_Paracoccidioides_brasiliensis_Pb18"
input_fasta="GCF_000150735.1_Paracocci_br_Pb18_V2_genomic.fna"
output_fasta="GCF_000150735.1_Paracocci_br_Pb18_V2_genomic_kraken.fasta"


grep "^>" $DIR/$input_fasta | head

sed 's/^>\([^ ]*\)/>kraken:taxid|502780|\1/' $DIR/$input_fasta > $DIR/$output_fasta

grep "^>" $DIR/$output_fasta | head

