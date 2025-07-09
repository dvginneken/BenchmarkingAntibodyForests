## Compare clonotypes between Platypus and Dowser
library(dplyr)
library(dowser)
library(AntibodyForests)
library(stringr)
library(ape)
# Load VDJ dataframe from Platypus
load("outputs/Platypus_clones.RData")
# Load AIRR formatted dataframe from Dowser
load("outputs/ChangeO_HC.RData")
# Reformat dowser data
data$clonotype_id <- data$clone_id
data$isotype <- data$c_call
data$isotype[data$isotype == ""] <- "Unknown"
data$barcode <- str_split_i(data$sequence_id, "-", i=1)
sort(table(data$clonotype_id), decreasing = T)

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
nrow(data[data$clonotype_id == "2298",])
vdj$clonotype_frequency[vdj$clonotype_id == "clonotype1"]
vdj$barcode[vdj$clonotype_id == "clonotype1"] %in% data$barcode[data$clonotype_id == "2298"]
plotTrees(clones[clones$clone_id == "2298",],
          tip_nums = T)
Af_plot_tree(af,
             clonotype = "clonotype1",
             sample = "CellRanger_SRR17729692",
             show.inner.nodes = T)
af[["CellRanger_SRR17729692"]]$clonotype1$phylo
clones[clones$clone_id == "2291",]$trees
clones[clones$clone_id == "2291",]$data

# Make comparable phylo objects of both trees
dowser_phylo <- clones[clones$clone_id == "2298",]$trees[[1]]
dowser_phylo$tip.label <- str_split_i(dowser_phylo$tip.label, "-", i=1)
af_phylo <- af[["CellRanger_SRR17729692"]]$clonotype1$phylo
af_phylo <- root(af_phylo, outgroup = "germline", resolve.root = T)

df <- data.frame("node" = character(),
                 "barcodes" = character())
for(node_nr in names(af[["CellRanger_SRR17729692"]]$clonotype1$nodes)){
  df <- rbind(df, data.frame("node" = rep(node_nr, af[["CellRanger_SRR17729692"]]$clonotype1$nodes[[node_nr]]$size), 
                             "barcodes" = af[["CellRanger_SRR17729692"]]$clonotype1$nodes[[node_nr]]$barcodes))
}
df <- rbind(df, c("germline", "Germline"))
dowser_phylo$tip.label <- df[match(dowser_phylo$tip.label, df$barcodes), "node"]

#plot
plot.phylo(dowser_phylo,
           use.edge.length = F)
plot.phylo(af_phylo,
           use.edge.length = F)

# compare
dist.topo(dowser_phylo, af_phylo)

#Second largest clone
nrow(data[data$clonotype_id == "1756",])
vdj$clonotype_frequency[vdj$clonotype_id == "clonotype2"]
vdj$barcode[vdj$clonotype_id == "clonotype2"] %in% data$barcode[data$clonotype_id == "1713"]

#Third largest clone
nrow(data[data$clonotype_id == "1662",])
vdj$clonotype_frequency[vdj$clonotype_id == "clonotype3"]
vdj$barcode[vdj$clonotype_id == "clonotype3"] %in% data$barcode[data$clonotype_id == "1662"]

plotTrees(clones[clones$clone_id == "1662",],
          tip_nums = T)
Af_plot_tree(af,
             clonotype = "clonotype3",
             sample = "CellRanger_SRR17729692",
             show.inner.nodes = T)

# Make comparable phylo objects of both trees
dowser_phylo <- clones[clones$clone_id == "1662",]$trees[[1]]
dowser_phylo$tip.label <- str_split_i(dowser_phylo$tip.label, "-", i=1)
af_phylo <- af[["CellRanger_SRR17729692"]]$clonotype2$phylo
af_phylo <- root(af_phylo, outgroup = "germline", resolve.root = T)

df <- data.frame("node" = character(),
                 "barcodes" = character())
for(node_nr in names(af[["CellRanger_SRR17729692"]]$clonotype2$nodes)){
  df <- rbind(df, data.frame("node" = rep(node_nr, af[["CellRanger_SRR17729692"]]$clonotype2$nodes[[node_nr]]$size), 
                             "barcodes" = af[["CellRanger_SRR17729692"]]$clonotype2$nodes[[node_nr]]$barcodes))
}
df <- rbind(df, c("germline", "Germline"))
dowser_phylo$tip.label <- df[match(dowser_phylo$tip.label, df$barcodes), "node"]

#plot
plot.phylo(dowser_phylo,
           use.edge.length = F)
plot.phylo(af_phylo,
           use.edge.length = F)
