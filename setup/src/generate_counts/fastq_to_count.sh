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
    r1_fastqc_directory="$counts_file_name_directory""/R1_fastqc/"
    r2_fastqc_directory="$counts_file_name_directory""/R2_fastqc/"
    trimmomatic_directory="$counts_file_name_directory""/trimmomatic/"
    mkdir -p {"$r1_fastqc_directory","$r2_fastqc_directory","$trimmomatic_directory"}

    # Remake sample file names, R1gz=full gzip name, R1=file name without path or gz, for outfile naming
    R1="$file_name""_R1_001.fastq"
    R1gz="$data_directory_samples""$R1"".gz"
    R2="$file_name""_R2_001.fastq"
    R2gz="$data_directory_samples""$R2"".gz"

    # Fastqc generate report
    zcat "$R1gz" | fastqc stdin -t "$threads" -o "$r1_fastqc_directory"
    zcat "$R2gz" | fastqc stdin -t "$threads" -o "$r2_fastqc_directory"

    # # Trimmomatic to process read 1
    java -jar "$script_directory""/Trimmomatic-0.39/trimmomatic-0.39.jar" SE -phred33 -threads "$threads" "$R1gz" "$trimmomatic_directory""minlencrop_""$R1" MINLEN:"$R1_length" CROP:"$R1_length" # Remove R1 shorter than $R1_length, crop all R1 reads to $R1_length
    pigz -f "$trimmomatic_directory""minlencrop_""$R1"
    java -jar "$script_directory""/Trimmomatic-0.39/trimmomatic-0.39.jar" PE -phred33 -threads "$threads" "$trimmomatic_directory""minlencrop_""$R1"".gz" "$R2gz" "$trimmomatic_directory""paired_""$R1"  "$trimmomatic_directory""singles_""$R1" "$trimmomatic_directory""paired_""$R2"  "$trimmomatic_directory""singles_""$R2" LEADING:"3" # Remove singletons
    pigz -f "$trimmomatic_directory"*
    STAR --runThreadN "$threads" --soloType CB_UMI_Simple \
    --soloUMIlen "$umi_length" \
    --soloBarcodeReadLength "$R1_length" \
    --soloCBlen "$cb_length" \
    --soloCBwhitelist "$whitelist" \
    --outSAMtype BAM SortedByCoordinate --twopassMode Basic --genomeDir "$star_genome_directory" \
    --readFilesCommand zcat --readFilesIn "$trimmomatic_directory""paired_""$R2"".gz" "$trimmomatic_directory""paired_""$R1"".gz"
#   --soloFeatures Gene GeneFull SJ Velocyto \
#   --outReadsUnmapped Fastx \
done

cd "$original_directory"
# https://jmorp.megabank.tohoku.ac.jp/dj1/datasets/tommo-jg2.0.0.beta-20200831/files/JG2.0.0beta.fa.gz?download=true