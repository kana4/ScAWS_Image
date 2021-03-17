#!/bin/bash
# Script to download grch38 and generate a STAR genome

# Make directories
directories=("$data_directory" "$star_genome_directory")
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
do if [ -f "$data_directory/$file" ]; then
echo "$file exists"
else
wget -O "$data_directory/$file" "$reference_top_url$file"
gunzip "$data_directory/$file"
fi; done

# Generate STAR genome
fasta="${genome_fasta%.*}" # get uncompressed name
gtf="${genome_gtf%.*}"
STAR --runThreadN "$threads" --runMode genomeGenerate --genomeDir "$star_genome_directory" \
--genomeFastaFiles "$data_directory/$fasta" --sjdbGTFfile "$data_directory/$gtf"

