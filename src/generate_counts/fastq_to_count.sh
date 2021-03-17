#!/bin/bash

while getopts f:g:d:t:o: flag
do
    case "${flag}" in
        d) download_directory=${OPTARG};;
        s) samples_directory=${OPTARG};;
        t) threads=${OPTARG};;
        o) out_directory=${OPTARG}
    esac
done

  STAR --runThreadN $threads --soloType CB_UMI_Simple \
  --soloUMIlen $umi_length \
  --soloBarcodeReadLength $R1_length \
  --soloCBlen $cb_length \
  --soloCBwhitelist $whitelist --soloFeatures Gene GeneFull SJ Velocyto --outReadsUnmapped Fastx --outSAMtype BAM SortedByCoordinate --twopassMode Basic --genomeDir $reference --readFilesCommand zcat --readFilesIn $R2_1,$R2_2,$R2_3,$R2_4 $R1_1,$R1_2,$R1_3,$R1_4
