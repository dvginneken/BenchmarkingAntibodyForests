

# Build trees IgPhyML
docker run --platform linux/amd64 --rm \
  -v $(pwd):/data -w /data \
  immcantation/suite:4.3.0 \
  Rscript scripts/Dowser_IgPhyML.R