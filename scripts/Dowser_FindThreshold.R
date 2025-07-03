# Load required packages
library(alakazam)
library(shazam)
library(dplyr)

# load AIRR tsv data (After MakeDb.py)
data <- read.delim("CellRanger_SRR17729692/filtered_contig_igblast_db-pass.tsv", header = TRUE, sep = "\t")
# remove cells with multiple heavy or light chains
data %>% group_by(cell_id, locus) %>%
  summarise(n = n()) %>% 
  filter(n > 1) %>%
  select(cell_id) -> remove
data <- data[!(data$cell_id %in% remove$cell_id), ]
# using nearest neighbor distances to determine clonal assignment thresholds¶
dist_sc <- distToNearest(data, cellIdColumn="cell_id", locusColumn="locus", 
                         VJthenLen=FALSE, onlyHeavy=FALSE, model="ham")
# Find threshold using density method
output <- findThreshold(dist_sc$dist_nearest, method="density")
threshold <- output@threshold
cat(threshold)