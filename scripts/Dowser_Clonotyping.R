# Load required packages
library(dowser)
library(stringr)

# Load cloned heavy chain AIRR tsv data
data <- read.delim("CellRanger_SRR17729692/heavy_parse-select_clone-pass.tsv", header = TRUE, sep = "\t")
# Select only the first germline genes
data$v_call <- str_trim(str_split_fixed(data$v_call, ",", 2)[,1])
data$d_call <- str_trim(str_split_fixed(data$d_call, ",", 2)[,1])
data$j_call <- str_trim(str_split_fixed(data$j_call, ",", 2)[,1])
# Load IMGT references
IGH <- readIMGT("IMGT_database/human_IGH")
imgt <- list(IGH = IGH)
imgt$IGH$D <- imgt$IGH$d[[1]]
imgt$IGH$V <- imgt$IGH$v[[1]]
imgt$IGH$J <- imgt$IGH$j[[1]]
data <- createGermlines(data, references = imgt, trim_lengths = T)
#save(data, file = "outputs/ChangeO_HC.RData")
# Format clones
clones = formatClones(data, minseq = 2)
#save(clones, file = "outputs/Dowser_clones_HC.RData")


