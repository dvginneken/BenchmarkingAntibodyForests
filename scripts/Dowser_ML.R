# Load required packages
library(dowser)
# Load clones
load("outputs/Dowser_clones_HC.RData")
# Building maximum likelihood trees 
clones <- getTrees(clones, build = "pml")
# Save the clones object with trees
#save(clones, file="outputs/Dowser_ML.RData")