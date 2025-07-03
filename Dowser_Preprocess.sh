PATH=$PATH:/opt/anaconda3/envs/igphyml/share
PATH=$PATH:/opt/anaconda3/envs/igphyml/share/igphyml/src
export IGDATA="/Users/dginneke/OneDrive - UMC Utrecht/Documenten/IMGT_database/"
export PATH=$HOME/.local/bin:$PATH

# Execute igblastn to assign V(D)J gene annotations
AssignGenes.py igblast -s CellRanger_SRR17729692/filtered_contig.fasta -b /opt/anaconda3/envs/igphyml/share/igblast --organism human --loci ig --format blast
# Create database files to store sequence alignment information with the IMGT reference sequences
MakeDb.py igblast -i CellRanger_SRR17729692/filtered_contig_igblast.fmt7 -s CellRanger_SRR17729692/filtered_contig.fasta -r /opt/anaconda3/envs/igphyml/share/germlines/imgt/human/vdj/imgt_human_*.fasta --10x CellRanger_SRR17729692/filtered_contig_annotations.csv --extended
# Find clustering threshold for clonotyping
threshold=$(Rscript scripts/Dowser_FindThreshold.R)
echo $threshold
# Splitting into separate light and heavy chain files
ParseDb.py select -d CellRanger_SRR17729692/filtered_contig_igblast_db-pass.tsv -f locus -u "IGH" --logic all --regex --outname heavy
#ParseDb.py select -d CellRanger_SRR17729692/filtered_contig_igblast_db-pass.tsv -f locus -u "IG[LK]" --logic all --regex --outname light
#Assigning clones heavy chains
DefineClones.py -d CellRanger_SRR17729692/heavy_parse-select.tsv --act set --model ham --norm len --dist $threshold
#Assigning clones light chains
#python3 scripts/light_cluster.py -d CellRanger_SRR17729692/heavy_parse-select_clone-pass.tsv -e CellRanger_SRR17729692/light_parse-select.tsv -o CellRanger_SRR17729692/10X_clone-pass.tsv
# Format clones
Rscript scripts/Dowser_Clonotyping.R
