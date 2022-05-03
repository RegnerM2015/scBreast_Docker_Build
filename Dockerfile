FROM rocker/rstudio:4.1.2

# Set global R options
RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install Seurat's system dependencies
RUN apt-get update
RUN apt-get install -y \
    libhdf5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libpng-dev \
    libboost-all-dev \
    libxml2-dev \
    openjdk-8-jdk \
    python3-dev \
    python3-pip \
    wget \
    git \
    libfftw3-dev \
    libgsl-dev \
    libsuitesparse-dev \
    liblpsolve55-dev \
    llvm-10 \
    libbz2-dev \
    libclang-dev \
    liblzma-dev \
    libcairo2-dev \
    libxt-dev

# Install UMAP
RUN LLVM_CONFIG=/usr/lib/llvm-10/bin/llvm-config pip3 install llvmlite
RUN pip3 install numpy
RUN pip3 install umap-learn

# Install FIt-SNE
RUN git clone --branch v1.2.1 https://github.com/KlugerLab/FIt-SNE.git
RUN g++ -std=c++11 -O3 FIt-SNE/src/sptree.cpp FIt-SNE/src/tsne.cpp FIt-SNE/src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm

# Install CRAN suggests
RUN R --no-echo --no-restore --no-save -e "install.packages(c('VGAM', 'R.utils', 'Rfast2', 'ape', 'enrichR', 'mixtools'))"

# Install hdf5r
RUN R --no-echo --no-restore --no-save -e "install.packages('hdf5r')"

# Install devtools
RUN R --no-echo --no-restore --no-save -e "install.packages('devtools')"

# Install remotes
RUN R --no-echo --no-restore --no-save -e "install.packages('remotes')"

# Colors
RUN R --no-echo --no-restore --no-save -e "install.packages('viridis')"
RUN R --no-echo --no-restore --no-save -e "install.packages('RColorBrewer')"

# msigdbr
RUN R --no-echo --no-restore --no-save -e "install.packages('msigdbr')"

# psych
RUN R --no-echo --no-restore --no-save -e "install.packages('psych')"

# stringr/stringi
RUN R --no-echo --no-restore --no-save -e "install.packages('stringr')"
RUN R --no-echo --no-restore --no-save -e "install.packages('stringi')"

# Tidyverse
RUN R --no-echo --no-restore --no-save -e "install.packages('tidyverse')"

# Shiny
RUN R --no-echo --no-restore --no-save -e "install.packages('shiny')"

# Install bioconductor packages
RUN R --no-echo --no-restore --no-save -e "install.packages('BiocManager')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('Rhtslib','Rsamtools','GenomicAlignments','rtracklayer','BSgenome'))"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('scater','ConsensusClusterPlus','fgsea','SingleR','plotgardener','BSgenome.Hsapiens.UCSC.hg38','sva','chromVAR'))"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('DirichletMultinomial', 'ComplexHeatmap', 'BiocParallel', 'ChIPpeakAnno', 'cicero', 'DelayedArray', 'DelayedMatrixStats', 'ensembldb', 'Gviz', 'MatrixGenerics','sparseMatrixStats'))"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('multtest', 'S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'BiocGenerics', 'GenomicRanges', 'IRanges', 'monocle', 'Biobase', 'limma','EnsDb.Hsapiens.v86'))"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('JASPAR2016','JASPAR2018','JASPAR2020'))"

# Install Seurat
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('satijalab/seurat@f1b2593ea72f2e6d6b16470dc7b9e9b645179923')"

# Install SeuratDisk
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('mojaveazure/seurat-disk')"

# Harmony
RUN R --no-echo --no-restore --no-save -e "install.packages('gganimate')"
RUN R --no-echo --no-restore --no-save -e "remotes::install_github(c('immunogenomics/harmony','immunogenomics/presto','JEFworks/MUDAN'))"

# inferCNV
RUN apt-get update && . /etc/environment \
  && wget sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/Source/JAGS-4.3.0.tar.gz  -O jags.tar.gz \
  && tar -xf jags.tar.gz \
  && cd JAGS* && ./configure && make -j4 && make install
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('infercnv')"

# MultiK
RUN R --no-echo --no-restore --no-save -e "install.packages('sigclust')"
RUN R --no-echo --no-restore --no-save -e "devtools::install_github('siyao-liu/MultiK')"

# Install MACS2 (python3)
RUN pip3 install --no-cache-dir Cython
RUN pip3 install --no-cache-dir macs2==2.2.7.1

# Cairo
RUN R --no-echo --no-restore --no-save -e "install.packages('Cairo')"

# ArchR
RUN R --no-echo --no-restore --no-save -e "devtools::install_github('GreenleafLab/ArchR', ref='master', repos = BiocManager::repositories())"

# chromVAR motifs
RUN R --no-echo --no-restore --no-save -e "remotes::install_github(c('GreenleafLab/chromVARmotifs','GreenleafLab/motifmatchr'))"

# Hexbin
RUN R --no-echo --no-restore --no-save -e "install.packages('hexbin')"

# DoubletFinder
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('chris-mcginnis-ucsf/DoubletFinder')"

# clustree
RUN R --no-echo --no-restore --no-save -e "install.packages('clustree')"

# Install mutoss and metap
RUN R --no-echo --no-restore --no-save -e "install.packages('mutoss')"
RUN R --no-echo --no-restore --no-save -e "install.packages('metap')"

# Install ggdendro and dendextend
RUN R --no-echo --no-restore --no-save -e "install.packages('ggdendro')"
RUN R --no-echo --no-restore --no-save -e "install.packages('dendextend')"

# Install fpc 
RUN R --no-echo --no-restore --no-save -e "install.packages('fpc')"

