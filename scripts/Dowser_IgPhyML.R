#docker run -it --rm -v /Users/dginneke/Documents/GitHub/BenchmarkingAntibodyForests:/data -w /data immcantation/suite:4.3.0 R

# Load required packages
library(dowser)
# Load clones
load("outputs/Dowser_clones_HC.RData")
# Building maximum likelihood trees using IgPhyML 
clones <- getTrees(clones, build="igphyml", nproc=1,
                   exec="/usr/local/share/igphyml/src/igphyml")
# Save the clones object with trees
save(clones, file="outputs/Dowser_IgPhyML.RData")