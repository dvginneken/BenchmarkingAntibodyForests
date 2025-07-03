# Load required packages
library(dowser)
# Load clones
load("outputs/Dowser_clones_HC.RData")
# Building trees using maximum parsimony
clones <- getTrees(clones)
# Save the clones object with trees
#save(clones, file="outputs/Dowser_MP.RData")
