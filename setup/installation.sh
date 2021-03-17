#!/bin/bash

# Master script to read the installation yaml for ScAWS installation and setup
# Please run this script with sudo ./installation.sh

# Exports all set variables
set -a

###########################Parameters###########################
# data_directory="/Users/l/Desktop/projects/github/ScAWS_Image/data/"
# -d downloaded_genome -o star_genome
###########################End Parameters###########################

# Gets parameters from command line
while getopts d:s:o flag
do
    case "${flag}" in
        d) data_directory=${OPTARG};;
        s) star_genome_directory=${OPTARG};;
        o) star_out_directory=${OPTARG}
    esac
done

# Set variables and run worker scripts

threads="$(nproc)"
data_directory_samples="$data_directory""samples/"
data_directory_genomes="$data_directory""genomes/"
links_file="$data_directory_genomes""links.txt"

umi_length="26"

# Reference variables
reference_top_url="ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_37/"
genome_fasta="GRCh38.primary_assembly.genome.fa.gz"
genome_gtf="gencode.v37.primary_assembly.annotation.gtf.gz"

# ./src/install_prerequisites/apt_install.sh
# ./src/install_prerequisites/r_install.r
# ./src/download_files/download_gencode.sh
# ./src/download_files/download_data.sh
# ./src/generate_counts/generate_star_genome.sh
./src/generate_counts/fastq_to_count.sh




# function parse_yaml {
#    local prefix=$2
#    local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
#    sed -ne "s|^\($s\):|\1|" \
#         -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
#         -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
#    awk -F$fs '{
#       indent = length($1)/2;
#       vname[indent] = $2;
#       for (i in vname) {if (i > indent) {delete vname[i]}}
#       if (length($3) > 0) {
#          vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
#          printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
#       }
#    }'
# }

# eval $(parse_yaml ./installation.yaml)

