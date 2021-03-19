#!/bin/bash

# Master script for installation, download, and generation of read counts
# Please run this script with sudo

    ###################### 
    # Add FastQC to the sudo path with sudo visudo and append /usr/bin/FastQC
    ######################

# Exports all set variables
set -a

###########################Parameters###########################
data_directory="/home/ubuntu/data/"
data_directory_samples="$data_directory""samples/"
star_genome_directory="$data_directory""genomes/"
star_out_directory="$data_directory""counts/"
chemistry="10xv2"
# ./setup.sh -d /home/ubuntu/data/ -s genomes/ -o counts/ -c 10xv2
###########################End Parameters###########################

# Gets parameters from command line
# while getopts d:s:o:c: flag
# do
#     case "${flag}" in
#         d) data_directory=${OPTARG};;
#         s) star_genome_directory=${OPTARG};;
#         o) star_out_directory=${OPTARG};;
#         c) chemistry=${OPTARG}
#     esac
# done

# Set variables and run worker scripts
script_directory="$(pwd)"
threads="$(nproc)"
data_directory_samples="$data_directory""samples/"
data_directory_genomes="$data_directory""genomes/"
star_out_directory="$data_directory""counts/"
links_file="$data_directory_genomes""links.txt"

# 10X genomics chemistry variables
if [ "$chemistry" = "10xv2" ]
then
  R1_length="26"
  whitelist="$data_directory""737K-august-2016.txt"
  bc_pattern="CCCCCCCCCCCCCCCCNNNNNNNNNN"
  umi_length="10"
  cb_length="16"
fi

if [ "$chemistry" = "10xv3" ]
then
  R1_length="28"
  whitelist="$data_directory""3M-february-2018.txt"
  bc_pattern="CCCCCCCCCCCCCCCCNNNNNNNNNNNN"
  umi_length="12"
  cb_length="16"
fi

# Reference variables
reference_top_url="ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_37/"
genome_fasta="GRCh38.primary_assembly.genome.fa.gz"
genome_gtf="gencode.v37.primary_assembly.annotation.gtf.gz"

# ./src/install_prerequisites/apt_install.sh
# ./src/install_prerequisites/r_install.r

    ###################### 
    # Add FastQC to the sudo path with sudo visudo
    ######################

./src/download_files/download_data.sh
./src/download_files/download_whitelist.sh
./src/generate_counts/generate_star_genome.sh
./src/generate_counts/fastq_to_count.sh
