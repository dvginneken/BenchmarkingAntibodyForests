library(AntibodyForests)
source("~/Documents/GitHub/AntibodyForests/R/VDJ_import_IgBLAST_annotations.R")
# Load clones
load("outputs/Platypus_clones.RData")

# Only keep clones with at least 2 unique sequences
library(dplyr)
vdj %>% group_by(clonotype_id) %>%
  summarise(unique_sequences = n_distinct(VDJ_sequence_nt_trimmed)) %>%
  filter(unique_sequences > 1) -> df2
vdj[vdj$clonotype_id %in% df2$clonotype_id,] -> vdj

# Import IgBLAST annotations
vdj <- VDJ_import_IgBLAST_annotations(VDJ = vdj,
                                      file.path.list = list(CellRanger_SRR17729692 = "/Users/dginneke/Documents/GitHub/BenchmarkingAntibodyForests/CellRanger_SRR17729692/filtered_contig_igblast_db-pass.tsv"),
                                      method = "replace")
# Write the VDJ dataframe into an AIRR-formatted TSV file
VDJ_to_AIRR(VDJ = vdj,
            output.file = "outputs/AntibodyForests_airr_rearrangement.tsv")
