################################################################################
####################### Merged compare (back to shell) #########################
################################################################################
library(tidyverse)

dup_reference_tmap <- read.table("./pbs_stringtie_remove_duplicated_RF_with_reference/merge/ALL_merged_compare.ALL_merged.gtf.tmap", header = T)
dup_reference_refmap <- read.table("./pbs_stringtie_remove_duplicated_RF_with_reference//merge/ALL_merged_compare.ALL_merged.gtf.refmap", header = T)
dup_reference_annot <- as.data.frame(rtracklayer::import("./pbs_stringtie_remove_duplicated_RF_with_reference//merge/ALL_merged_compare.annotated.gtf"))

table(dup_reference_tmap$class_code)

### Remove protein-coding to CPC2 and PLEK (back to shell)

all(dup_reference_tmap %>% filter(class_code == "=") %>% pull(ref_id) %in% dup_reference_refmap$ref_id)

classes_different <- dup_reference_tmap %>% filter(class_code != "=") %>% pull(qry_id)

length(classes_different) == (nrow(dup_reference_tmap)-nrow(dup_reference_refmap))

gtf_remove_prot <- dup_reference_annot %>% 
  filter(transcript_id %in% classes_different) %>% 
  filter(strand %in% c("+", "-"))

length(gtf_remove_prot %>% filter(type == "transcript") %>% pull(transcript_id) %>% unique())

rtracklayer::export(gtf_remove_prot,"./pbs_stringtie_remove_duplicated_RF_with_reference/ALL_merged_compare.annotated.remove_prot.gtf", format = "gtf")