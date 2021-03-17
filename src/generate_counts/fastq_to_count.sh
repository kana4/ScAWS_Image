#!/bin/bash

while getopts f:g:d:t:o: flag
do
    case "${flag}" in
        d) genome_directory=${OPTARG};;
        d) genome_directory=${OPTARG};;
        t) threads=${OPTARG};;
        o) out_directory=${OPTARG};;
    esac
done

