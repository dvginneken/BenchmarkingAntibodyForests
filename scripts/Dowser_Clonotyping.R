# Load required packages
library(dowser)
library(stringr)

# Load cloned heavy chain AIRR tsv data (After light_cluster.py)
data <- read.delim("CellRanger_SRR17729692/heavy_parse-select_clone-pass.tsv", header = TRUE, sep = "\t")
# Load the light chain AIRR tsv data
#data_LC <- read.delim("CellRanger_SRR17729692/light_parse-select.tsv", header = TRUE, sep = "\t")
#data_LC$clone_id <- NA
#data <- rbind(data_HC, data_LC)
# Add light chains to the clones
#data <- resolveLightChains(data)
# Select only the first germline genes
data$v_call <- str_trim(str_split_fixed(data$v_call, ",", 2)[,1])
data$d_call <- str_trim(str_split_fixed(data$d_call, ",", 2)[,1])
data$j_call <- str_trim(str_split_fixed(data$j_call, ",", 2)[,1])
# Load IMGT references
# IGH
IGH <- readIMGT("IMGT_database/human_IGH")
imgt <- list(IGH = IGH)
imgt$IGH$D <- imgt$IGH$d[[1]]
imgt$IGH$V <- imgt$IGH$v[[1]]
imgt$IGH$J <- imgt$IGH$j[[1]]
# IGL
# IGL <- readIMGT("IMGT_database/human_IGL")
# imgt$IGL <- IGL
# imgt$IGL$J <- imgt$IGL$j[[1]]
# imgt$IGL$V <- imgt$IGL$v[[1]]
# # IGK
# IGK <- readIMGT("IMGT_database/human_IGK")
# imgt$IGK <- IGK
# imgt$IGK$J <- imgt$IGK$j[[1]]
# imgt$IGK$V <- imgt$IGK$v[[1]]
# Create germline alignments
#data <- createGermlines(data, references = imgt, trim_lengths = T, clone = "clone_subgroup_id")
data <- createGermlines(data, references = imgt, trim_lengths = T)
#save(data, file = "outputs/ChangeO_HC.RData")
# Format clones
#clones = formatClones(data, chain = "HL", collapse = F, split_light = T, minseq = 1)
clones = formatClones(data, minseq = 2)
save(clones, file = "outputs/Dowser_clones_HC.RData")


