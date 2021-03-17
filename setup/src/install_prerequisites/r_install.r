#!/usr/bin/Rscript

# Requires >2 gb ram, should be run as sudo su for aws intance

install.packages(c(
    "devtools"
    , "Rcpp"
    , "ggplot2"
    , "data.table"
    , "patchwork"
    , "tidyverse"
    ))

# May need to install spatstat separately, recent error will probably be updated soon
install.packages('https://cran.r-project.org/src/contrib/Archive/spatstat/spatstat_1.64-1.tar.gz', repos=NULL,type="source")
install.packages("Seurat")

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(version = "3.12")

BiocManager::install(c("GenomicFeatures"
                       , "AnnotationDbi"
                       , "biomaRt"
                       , "limma"
                       , "GenomicAlignments"
                       , "rtracklayer"
                       , "Gviz"
                       , "topGO"
                       , "scran"
                       , "SingleR"
                       , "DropletUtils"
                       , "edgeR"
))


# Install R demonstration package
devtools::install_github("https://github.com/otsukaresamadeshita/ScAWS", auth_token="89cc546cbff1b2119d1c378b7858a773382c94c5")

