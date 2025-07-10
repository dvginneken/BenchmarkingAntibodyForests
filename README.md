# Benchmarking AntibodyForests
Compare computational speed and memory usage of B cell lineage reconstruction with [AntibodyForests](https://github.com/alexyermanos/AntibodyForests) and [Dowser](https://github.com/immcantation/dowser).

## Data
1. Download single-cell BCR sequencing data from the NCBI Sequence Read Archive (ID:SRR17729692) using [SRA-toolkit](https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit)
2. Process this data with the [CellRanger VDJ pipeline (v8.0.0)](https://www.10xgenomics.com/support/software/cell-ranger/latest/tutorials/cr-tutorial-in) and save the output in a folder named 'Cellranger_SRR17729692'

## IMGT references
1. Download the human IGHV, IGHD, and IGHJ reference sequences from [IMGT](https://www.imgt.org/genedb/) and save these in the folder 'IMGT_database'

## Installation
Install packages from CRAN.
```
install.packages("Platypus")
install.packages("AntibodyForests")
install.packages("alakazam")
install.packages("dowser")
```

Install from pip
```
pip3 install changeo --user
```

Install [IgPhyML](https://igphyml.readthedocs.io/en/latest/index.html) via Docker
```
docker pull immcantation/suite:4.6.0
```

## Perfrom benchmarking
Run the bash scripts for preprocessing and tree reconstruction
```
# example
/usr/bin/time -l ./AntibodyForests_Preprocess.sh 2> log/AntibodyForests_Preprocess.log
```
