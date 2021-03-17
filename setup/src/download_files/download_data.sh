#!/bin/bash

# Downloads data from SRA, links are nonuniform
original_directory="$(pwd)"
mkdir "$data_directory_samples"
cd "$data_directory_samples"



wget https://sra-download.ncbi.nlm.nih.gov/traces/sra47/SRZ/013734/SRR13734384/IVAR2_5D_CKDL200155936-1a-SI_GA_B2_H5NG5DSXY_S3_L004_R1_001.fastq.gz
wget https://sra-pub-sars-cov2.s3.amazonaws.com/sra-src/SRR13734384/IVAR2_5D_CKDL200155936-1a-SI_GA_B2_H5NG5DSXY_S3_L004_R2_001.fastq.gz.1
mv IVAR2_5D_CKDL200155936-1a-SI_GA_B2_H5NG5DSXY_S3_L004_R2_001.fastq.gz.1 IVAR2_5D_CKDL200155936-1a-SI_GA_B2_H5NG5DSXY_S3_L004_R2_001.fastq.gz

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra72/SRZ/013734/SRR13734385/IVAR3_5D_CKDL200155937-1a-SI_GA_C2_H5NG5DSXY_S2_L004_R1_001.fastq.gz
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra72/SRZ/013734/SRR13734385/IVAR3_5D_CKDL200155937-1a-SI_GA_C2_H5NG5DSXY_S2_L004_R2_001.fastq.gz

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra5/SRZ/013734/SRR13734387/IVAR55D_S16_L002_R1_001.fastq.gz
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra5/SRZ/013734/SRR13734387/IVAR55D_S16_L002_R2_001.fastq.gz

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra76/SRZ/013734/SRR13734390/IVAR65D_S3_L003_R1_001.fastq.gz
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra76/SRZ/013734/SRR13734390/IVAR65D_S3_L003_R2_001.fastq.gz

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra4/SRZ/013734/SRR13734393/IVAR85D_S10_L002_R1_001.fastq.gz
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra4/SRZ/013734/SRR13734393/IVAR85D_S10_L002_R2_001.fastq.gz

wget https://sra-download.ncbi.nlm.nih.gov/traces/sra55/SRZ/013734/SRR13734397/IVAR105D_S12_L002_R1_001.fastq.gz
wget https://sra-download.ncbi.nlm.nih.gov/traces/sra55/SRZ/013734/SRR13734397/IVAR105D_S12_L002_R2_001.fastq.gz

cd "$original_directory"