#!/bin/bash

# Runs STAR for each pair of reads in the samples folder.
original_directory="$(pwd)"
cd "$data_directory_samples"
mkdir "$star_out_directory"

for file_name in $(ls *.fastq.gz | sed -r 's/_R[12]_001[.]fastq[.]gz//' | uniq); do
    # Make directories for samples and fastqc outputs
    counts_file_name_directory="$star_out_directory""$file_name"
    mkdir "$counts_file_name_directory"
    cd "$counts_file_name_directory"
    mkdir "$counts_file_name_directory""/R1_fastqc"
    mkdir "$counts_file_name_directory""/R2_fastqc"
    R1="$data_directory_samples""$file_name""_R1_001.fastq.gz"
    R2="$data_directory_samples""$file_name""_R2_001.fastq.gz"
    # Fastqc generate report
    # zcat "$R1" | fastqc stdin -t "$threads" -o "$counts_file_name_directory""/R1_fastqc"
    # zcat "$R2" | fastqc stdin -t "$threads" -o "$counts_file_name_directory""/R2_fastqc"
    # Remove all read 1's (and their pairs) shorter than $R1_length, as we won't be able to assign these with hamming distance=1
    # bioawk -c fastx '{ print $name, length($seq) }' < $R1 # Remove R1 shorter 
    # java -jar trimmomatic-0.39.jar "$R1" MINLEN:"$R1_length" # Remove R1 shorter than $R1_length
    # java -jar ./trimmomatic-0.30.jar PE -threads "$threads" -phred33 R1.fastq R2.fastq R1_paired.fastq R1_singles.fastq R2_paired.fastq R2_singles.fastq
    # trimmomatic-0.39.jar # Remove singletons
    STAR --runThreadN "$threads" --soloType CB_UMI_Simple \
    --soloUMIlen "$umi_length" \
    --soloBarcodeReadLength "$R1_length" \
    --soloCBlen "$cb_length" \
    --soloCBwhitelist "$whitelist" \
    --outSAMtype BAM SortedByCoordinate --twopassMode Basic --genomeDir "$star_genome_directory" \
    --readFilesCommand zcat --readFilesIn "$R2" "$R1"
#   --soloFeatures Gene GeneFull SJ Velocyto \
#   --outReadsUnmapped Fastx \
done

cd "$original_directory"
# https://jmorp.megabank.tohoku.ac.jp/dj1/datasets/tommo-jg2.0.0.beta-20200831/files/JG2.0.0beta.fa.gz?download=true