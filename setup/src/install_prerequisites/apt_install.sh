#!/bin/bash

# Install apt packages
apt --assume-yes update
apt --assume-yes upgrade
apt --assume-yes install libgit2-dev lynx pigz bison flex zlib1g zlib1g-dev make
apt --assume-yes install openjdk-11-jre-headless

# # Install R and dependencies
# For aws arm instances, R doesn't install 4.0 yet but 3.6.3 and the arm fortran compiler is in beta, this script is being used on an intel instance 
apt --assume-yes install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
apt --assume-yes install r-base-core 
apt --assume-yes install r-recommended r-base-dev
apt --assume-yes install build-essential libapparmor1 libcurl4-gnutls-dev libxml2-dev libssl-dev gdebi-core libcairo2-dev libxt-dev git-core

# Install bioawk (latest), STAR (latest), FastQC (v0.11.9)
if [ -a "/usr/bin/bioawk" ]; then
    echo "bioawk exists"
    else
    git clone https://github.com/lh3/bioawk && cd bioawk && make
    cp bioawk/bioawk /usr/bin
    cd ../; rm -rf bioawk
fi

if [ -a "/usr/bin/STAR" ]; then
    echo "STAR exists"
    else
    git clone https://github.com/alexdobin/STAR.git
    cd STAR/source
    make STAR
    cd ../; cd ../
    cp STAR/bin/Linux_x86_64/STAR /usr/bin
    rm -rf STAR
fi

# Install FastQC
if [ -d "/usr/bin/FastQC" ]; then
    echo "FastQC exists"
    else
    wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip
    unzip fastqc_v0.11.9.zip
    sudo chmod 755 FastQC/fastqc
    cp -r FastQC /usr/bin
    ###################### 
    # Appended to ~/.profile: export PATH=/usr/bin/FastQC:$PATH
    ######################
fi

# Install Trimmomatic
if [ -d "Trimmomatic-0.39" ]; then
    echo "Trimmomatic exists"
    else
    wget https://github.com/usadellab/Trimmomatic/files/5854859/Trimmomatic-0.39.zip
    unzip Trimmomatic-0.39.zip
fi

# Install Fastp
if [ -a "/usr/bin/fastp" ]; then
    echo "Fastp exists"
    else
    wget http://opengene.org/fastp/fastp
    chmod a+x ./fastp
    cp fastp /usr/bin
fi

# Install conda and snakemake
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
conda install -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
conda activate snakemake

# # Install Rust and Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
apt --assume-yes install cargo

#-------------Notes-------------

# Don't forget to append ~/.profile for fastqc after running this script

# Lines for installing R on arm when a compiler is available
# wget https://mirrors.nics.utk.edu/cran/src/base/R-4/R-4.0.4.tar.gz
# tar -xvf R-4.0.4.tar.gz
# cd R-4.0.4
