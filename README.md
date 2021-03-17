# ScAWS_Image

## Repository to generate and implement a single cell RNA Seq AWS instance.

For this example workflow, we use an m2.4xlarge instance with an 800 gb EBS disk. The base image is Ubuntu 20.04 on intel architechture. This repository includes everything apart from instance setup and ssh into the instance. Steps include:

<ul>Software Installation (Bash)</ul>
<ul>Reference and Data Download (Bash)</ul>
<ul>Alignment/Count (Python/Snakemake)</ul>
<ul>Processing/Visualization (R/Devtools)</ul>

The workflow investigates differential expression in disease and control states with sample data housed on the NCBI SRA. For more information, please refer to the [original paper by Kusnadi et al.](https://immunology.sciencemag.org/content/6/55/eabe4782).

The authors 

Notes: 
<ul> We do not recommend arm architechture at this time, as Ubuntu installs R 3.6 by apt, and this repository requires version 4.0. </ul>