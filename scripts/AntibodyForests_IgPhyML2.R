library(AntibodyForests)
# Load clones
load("outputs/AntibodyForests_clones_igphyml.RData")

#Create AntibodyForests object from IgPhyML output
af <- Af_build(VDJ = vdj,
                       sequence.columns = "VDJ_sequence_nt_trimmed",
                       germline.columns = "VDJ_germline_nt_trimmed",
                       construction.method = "phylo.tree.IgPhyML",
                       IgPhyML.output.file = "outputs/AntibodyForests_airr_rearrangement_igphyml-pass.tab")

save(af, file = "outputs/AntibodyForests_IgPhyML.RData")