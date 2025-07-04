library(AntibodyForests)
source("~/Documents/GitHub/AntibodyForests/R/Af_build.R")
# Load clones
load("outputs/Platypus_clones.RData")
# Building trees using distance based networks
af <- Af_build(vdj,
               sequence.columns = "VDJ_sequence_nt_trimmed",
               germline.columns = "VDJ_germline_nt_trimmed",
               construction.method = "phylo.network.default")
# Save the clones object with trees
#save(af, file="outputs/AntibodyForests_default.RData")

