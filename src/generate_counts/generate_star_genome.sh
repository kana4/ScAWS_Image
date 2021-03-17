#!/bin/bash
# Script to download grch38 and generate a STAR genome

# Get user inputs, for us the command should be:
# ./generate_star_genome.sh -f GRCh38.primary_assembly.genome.fa.gz -g gencode.v37.primary_assembly.annotation.gtf.gz -d downloaded_genome -t 16 -o star_genome

while getopts f:g:d:t:o: flag
do
    case "${flag}" in
        f) genome_fasta=${OPTARG};;
        g) genome_gtf=${OPTARG};;
        d) download_directory=${OPTARG};;
        t) threads=${OPTARG};;
        o) out_directory=${OPTARG}
    esac
done

# Make directories
directories=("$download_directory" "$out_directory")
for directory in "${directories[@]}"; do 
    if [ -d "$directory" ]; then
        echo "$directory exists"
    else 
        mkdir "$directory"
    fi
done

# Download genome files
files=( "$genome_fasta" "$genome_gtf" )
for file in "${files[@]}"
do if [ -f "$download_directory/$file" ]; then
echo "$file exists"
else
wget -O "$download_directory/$file" "ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_37/$file"
gunzip "$download_directory/$file"
fi; done

# Generate STAR genome
fasta="${genome_fasta%.*}" # get uncompressed name
gtf="${genome_gtf%.*}"
STAR --runThreadN "$threads" --runMode genomeGenerate --genomeDir "$out_directory" \
--genomeFastaFiles "$download_directory/$fasta" --sjdbGTFfile "$download_directory/$gtf"

