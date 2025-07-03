library(AntibodyForests)
# Load clones
load("outputs/Platypus_clones.RData")
# Building trees using maximum parisomony
af <- Af_build(vdj,
               sequence.columns = "VDJ_sequence_nt_raw",
               germline.columns = "VDJ_germline_nt_raw",
               construction.method = "phylo.tree.mp")
# Save the clones object with trees
#save(af, file="outputs/AntibodyForests_MP.RData")
