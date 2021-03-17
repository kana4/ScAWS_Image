#!/bin/bash

cd "$data_directory_samples"

for 
  STAR --runThreadN "$threads" --soloType CB_UMI_Simple \
  --soloUMIlen "$umi_length" \
  --soloBarcodeReadLength "$R1_length" \
  --soloCBlen "$cb_length" \
  --soloCBwhitelist "$whitelist" \
#   --soloFeatures Gene GeneFull SJ Velocyto \
#   --outReadsUnmapped Fastx \
  --outSAMtype BAM SortedByCoordinate --twopassMode Basic --genomeDir "$star_genome_directory" --readFilesCommand zcat --readFilesIn "$data_directory_samples""$R2_1" "$data_directory_samples""$R1_1"
