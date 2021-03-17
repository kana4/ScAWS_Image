#!/bin/bash

# Downloads 10x genomics 10xv2 and 10xv3 barcode whitelists
original_directory="$(pwd)"
cd "$data_directory_samples"
wget https://github.com/otsukaresamadeshita/10xv2_10xv3_barcodes/raw/master/3M-february-2018.txt.gz
wget https://github.com/otsukaresamadeshita/10xv2_10xv3_barcodes/raw/master/737K-august-2016.txt.gz
gunzip ./*
cd "$original_directory"