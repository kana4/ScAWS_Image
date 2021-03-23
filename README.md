# ScAWS_Image

## Repository to generate and implement a single cell RNA Seq AWS instance.

For this example workflow, we use an m2.4xlarge instance with an 2000 gb EBS disk. The base image is Ubuntu 20.04 on intel architechture. This repository includes everything apart from instance setup and ssh into the instance. Steps include:

<ul>Software Installation (Bash)</ul>
<ul>Reference and Data Download (Bash)</ul>
<ul>Alignment/Count (Bash)</ul>
<ul>Processing/Visualization (R)</ul>

The workflow investigates differential expression in disease and control states with sample data housed on the NCBI SRA.

Notes: 
<ul> We do not recommend arm architechture at this time, as Ubuntu installs R 3.6 by apt, and this repository requires version 4.0. </ul>