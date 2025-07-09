PATH=$PATH:/opt/anaconda3/envs/igphyml/share
PATH=$PATH:/opt/anaconda3/envs/igphyml/share/igphyml/src
export IGDATA="/Users/dginneke/OneDrive - UMC Utrecht/Documenten/IMGT_database/"
export PATH=$HOME/.local/bin:$PATH

# Execute igblastn to assign V(D)J gene annotations
AssignGenes.py igblast -s CellRanger_SRR17729692/filtered_contig.fasta -b /opt/anaconda3/envs/igphyml/share/igblast --organism human --loci ig --format blast
# Create database files to store sequence alignment information with the IMGT reference sequences
MakeDb.py igblast -i CellRanger_SRR17729692/filtered_contig_igblast.fmt7 -s CellRanger_SRR17729692/filtered_contig.fasta -r /opt/anaconda3/envs/igphyml/share/germlines/imgt/human/vdj/imgt_human_*.fasta --10x CellRanger_SRR17729692/filtered_contig_annotations.csv --extended
# Append to VDJ dataframe
Rscript scripts/AntibodyForests_IgPhyML1.R
# Build Trees
docker run --platform linux/amd64 --rm -v $(pwd):/data -w /data immcantation/suite:4.6.0 bash BuildTrees.sh
# Transform into AntibodyForests object
Rscript scripts/AntibodyForests_IgPhyML2.R