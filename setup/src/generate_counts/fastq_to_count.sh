#!/bin/bash

# Runs STAR for each pair of reads in the samples folder.
original_directory="$(pwd)"
cd "$data_directory_samples"
mkdir "$star_out_directory"

for name in $(ls *.fastq.gz | sed -r 's/_R[12]_001[.]fastq[.]gz//' | uniq); do
    mkdir "$star_out_directory""$name"
    cd "$star_out_directory""$name"
    R1="$name""R1_001.fastq.gz"
    R2="$name""R2_001.fastq.gz"
    STAR --runThreadN "$threads" --soloType CB_UMI_Simple \
    --soloUMIlen "$umi_length" \
    --soloBarcodeReadLength "$R1_length" \
    --soloCBlen "$cb_length" \
    --soloCBwhitelist "$whitelist" \
#   --soloFeatures Gene GeneFull SJ Velocyto \
#   --outReadsUnmapped Fastx \
  --outSAMtype BAM SortedByCoordinate --twopassMode Basic --genomeDir "$star_genome_directory" \
  --readFilesCommand zcat --readFilesIn "$data_directory_samples""$R2" "$data_directory_samples""$R1"
done

cd "$original_directory"