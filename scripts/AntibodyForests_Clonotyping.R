# Load the necessary library
library(Platypus)

#Build the VDJ dataframe
vdj <- VDJ_build(VDJ.sample.list = "CellRanger_SRR17729692",
                 remove.divergent.cells = T,
                 complete.cells.only = T, 
                 trim.germlines = T,
                 parallel = T)
#Only keep clones with at least 2 sequences
vdj <- vdj[vdj$clonotype_frequency > 1,]
#save(vdj, file = "outputs/Platypus_clones.RData")
