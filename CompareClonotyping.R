## Compare clonotypes between Platypus and Dowser
library(dplyr)
library(dowser)
library(AntibodyForests)
# Load VDJ dataframe from Platypus
load("outputs/Platypus_clones.RData")
# Load AIRR formatted dataframe from Dowser
load("outputs/ChangeO_HC.RData")
# Reformat dowser data
data$clonotype_id <- data$clone_id
data$isotype <- data$c_call
data$isotype[data$isotype == ""] <- "Unknown"
data$barcode <- str_split_i(data$sequence_id, "-", i=1)
# Make clonal expansion plots
source("scripts/VDJ_clonal_expansion.R")
VDJ_clonal_expansion(vdj,
                            clones = 50,
                            color.by = "isotype",
                            group.by = "none")

VDJ_clonal_expansion(data,
                            clones = 50,
                            color.by = "isotype",
                            group.by = "none",
                            sub.type = F)

# Load trees
load("outputs/AntibodyForests_MP.RData") #af
load("outputs/Dowser_MP.RData") #clones
#Largest clone
nrow(data[data$clonotype_id == "2291",])
vdj$clonotype_frequency[vdj$clonotype_id == "clonotype1"]
vdj$barcode[vdj$clonotype_id == "clonotype1"] %in% data$barcode[data$clonotype_id == "2291"]
plotTrees(clones[clones$clone_id == "2291",],
          tip_nums = T)
Af_plot_tree(af,
             clonotype = "clonotype1",
             sample = "CellRanger_SRR17729692",
             show.inner.nodes = F)
Af_plot_tree(af,
             clonotype = "clonotype1",
             sample = "CellRanger_SRR17729692",
             show.inner.nodes = T)
af[["CellRanger_SRR17729692"]]$clonotype1$phylo
clones[clones$clone_id == "2291",]$trees
unique(data[data$clonotype_id == "2291","sequence_alignment"])
unique(vdj[vdj$clonotype_id == "clonotype1", "VDJ_sequence_nt_raw"])


#Second largest clone
nrow(data[data$clonotype_id == "1713",])
vdj$clonotype_frequency[vdj$clonotype_id == "clonotype2"]
vdj$barcode[vdj$clonotype_id == "clonotype2"] %in% data$barcode[data$clonotype_id == "1713"]

#Third largest clone
nrow(data[data$clonotype_id == "1659",])
vdj$clonotype_frequency[vdj$clonotype_id == "clonotype3"]
vdj$barcode[vdj$clonotype_id == "clonotype3"] %in% data$barcode[data$clonotype_id == "1659"]
