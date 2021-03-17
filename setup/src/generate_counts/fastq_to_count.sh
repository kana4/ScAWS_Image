#!/bin/bash

# Runs STAR for each pair of reads in the samples folder.
original_directory="$(pwd)"
cd "$data_directory_samples"
mkdir "$star_out_directory"

for file_name in $(ls *.fastq.gz | sed -r 's/_R[12]_001[.]fastq[.]gz//' | uniq); do
    counts_file_name_directory="$star_out_directory""$file_name"
    mkdir "$counts_file_name_directory"
    cd "$counts_file_name_directory"
    R1="$file_name""R1_001.fastq.gz"
    R2="$file_name""R2_001.fastq.gz"
    # Fastqc generate report
    zcat "$R1" | fastqc stdin -t "$threads" -o "$counts_file_name_directory"
    # Remove all read 1's (and their pairs) shorter than $R1_length, as we won't be able to assign these with hamming distance=1
    # bioawk -c fastx '{ print $name, length($seq) }' < $R1 # Remove R1 shorter 
    # trimmomatic-0.39.jar # Remove R1 shorter than $R1_length
    # trimmomatic-0.39.jar # Remove singletons
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