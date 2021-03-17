#!/bin/bash

# Install apt packages
apt --assume-yes update
apt --assume-yes upgrade
apt --assume-yes install libgit2-dev lynx pigz bison flex zlib1g zlib1g-dev make
apt --assume-yes install openjdk-11-jre-headless

# # Install R and dependencies
# For aws arm instances, R doesn't install 4.0 yet but 3.6.3 and the fortran compiler is in beta, this script is being used on an intel instance 
apt --assume-yes install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
apt --assume-yes install r-base-core 
apt --assume-yes install r-recommended r-base-dev
apt --assume-yes install build-essential libapparmor1 libcurl4-gnutls-dev libxml2-dev libssl-dev gdebi-core libcairo2-dev libxt-dev git-core

# Lines for installing R on arm when a compiler is available
# wget https://mirrors.nics.utk.edu/cran/src/base/R-4/R-4.0.4.tar.gz
# tar -xvf R-4.0.4.tar.gz
# cd R-4.0.4

# Install bioawk into ~/tools
toolsdir="./tools"
if [ -d "$toolsdir" ]; then
    echo "toolsdir exists"
else
    mkdir "$toolsdir" && cd "$toolsdir"
    git clone https://github.com/lh3/bioawk
    cd bioawk && make 
fi

Install STAR, FastQC, Fastp, bbmap
cd ./tools
git clone https://github.com/alexdobin/STAR.git
cd STAR/source
make STAR

#replaces "/home/$login_name", since when we run this script with sudo, it calls root profile rather than login profile
# HOME="$(getent passwd $LOGNAME | cut -d: -f6)" 

# On Ubuntu 20.04:
login_name="$(logname)"

# Add tools directory to profile
if [ "$(grep -c "tools" "/home/""$login_name""/.profile")" -ge 3 ]; then
    echo "Already added to .profile"
else
    echo "export PATH=$PATH:""/home/""$login_name""/tools" >> "/home/""$login_name""/.profile"
fi

# # Add bioawk directory to profile
if [ "$(grep -c "bioawk" "/home/""$login_name""/.profile")" -ge 3 ]; then
    echo "Already added to .profile"
else
    echo "export PATH=$PATH:""/home/""$login_name""/tools/bioawk" >> "/home/""$login_name""/.profile"
fi

# # Add STAR directory to profile
if [ "$(grep -c "STAR" "/home/""$login_name""/.profile")" -ge 3 ]; then
    echo "Already added to .profile"
else
    echo "export PATH=$PATH:""/home/""$login_name""/tools/STAR/bin/Linux_x86_64" >> "/home/""$login_name""/.profile"
fi

# # Install Rust and Cargo
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# apt --assume-yes install cargo

source "/home/""$login_name""/.profile"
