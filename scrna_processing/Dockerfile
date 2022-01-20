# Dockerfile for the Seurat and all other software packages
FROM rocker/r-ver:4.1.1

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
    libgsl-dev 

RUN apt-get install -y llvm-10

# Install UMAP
RUN LLVM_CONFIG=/usr/lib/llvm-10/bin/llvm-config pip3 install llvmlite
RUN pip3 install numpy
RUN pip3 install umap-learn

# Install FIt-SNE
RUN git clone --branch v1.2.1 https://github.com/KlugerLab/FIt-SNE.git
RUN g++ -std=c++11 -O3 FIt-SNE/src/sptree.cpp FIt-SNE/src/tsne.cpp FIt-SNE/src/nbodyfft.cpp  -o bin/fast_tsne -pthread -lfftw3 -lm

# Install bioconductor dependencies & suggests
RUN R --no-echo --no-restore --no-save -e "install.packages('BiocManager')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('multtest', 'S4Vectors', 'SummarizedExperiment', 'SingleCellExperiment', 'MAST', 'DESeq2', 'BiocGenerics', 'GenomicRanges', 'IRanges', 'rtracklayer', 'monocle', 'Biobase', 'limma'))"

# Install CRAN suggests
RUN R --no-echo --no-restore --no-save -e "install.packages(c('VGAM', 'R.utils', 'metap', 'Rfast2', 'ape', 'enrichR', 'mixtools'))"

# Install hdf5r
RUN R --no-echo --no-restore --no-save -e "install.packages('hdf5r')"

# Install Seurat
RUN R --no-echo --no-restore --no-save -e "install.packages('remotes')"
RUN R --no-echo --no-restore --no-save -e "remotes::install_version('Seurat', version = '3.1.5')"

# Install SeuratDisk
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('mojaveazure/seurat-disk')"

#####################################
# Additional software packages below:
#####################################

# Additional Bioconductor packages
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('DirichletMultinomial', 'BSgenome', 'ComplexHeatmap', 'BiocParallel', 'ChIPpeakAnno', 'cicero', 'DelayedArray', 'DelayedMatrixStats', 'EnsDb.Hsapiens.v86', 'ensembldb', 'Gviz', 'MatrixGenerics','sparseMatrixStats'))"

# Harmony
RUN R --no-echo --no-restore --no-save -e "install.packages('gganimate')" 
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('sva','DESeq2'))" 
RUN R --no-echo --no-restore --no-save -e "remotes::install_github(c('immunogenomics/harmony','immunogenomics/presto','JEFworks/MUDAN'))"

# MultiK
RUN R --no-echo --no-restore --no-save -e "install.packages('sigclust')"
RUN R --no-echo --no-restore --no-save -e "install.packages('devtools')"
RUN R --no-echo --no-restore --no-save -e "devtools::install_github('siyao-liu/MultiK')"

# inferCNV
RUN apt-get update && . /etc/environment \
  && wget sourceforge.net/projects/mcmc-jags/files/JAGS/4.x/Source/JAGS-4.3.0.tar.gz  -O jags.tar.gz \
  && tar -xf jags.tar.gz \
  && cd JAGS* && ./configure && make -j4 && make install
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('infercnv')"

# Additional Bioconductor packages
RUN R --no-echo --no-restore --no-save -e "BiocManager::install(c('scater','ConsensusClusterPlus','fgsea','SingleR','plotgardener','BSgenome.Hsapiens.UCSC.hg38'))"

# Colors
RUN R --no-echo --no-restore --no-save -e "install.packages('viridis')"
RUN R --no-echo --no-restore --no-save -e "install.packages('RColorBrewer')"

# clustree
RUN R --no-echo --no-restore --no-save -e "install.packages('clustree')"

# msigdbr
RUN R --no-echo --no-restore --no-save -e "install.packages('msigdbr')"

# pysch
RUN R --no-echo --no-restore --no-save -e "install.packages('pysch')"

# stringr/stringi
RUN R --no-echo --no-restore --no-save -e "install.packages('stringr')"
RUN R --no-echo --no-restore --no-save -e "install.packages('stringi')"

# Tidyverse
RUN R --no-echo --no-restore --no-save -e "install.packages('tidyverse')"

# Shiny
RUN R --no-echo --no-restore --no-save -e "install.packages('shiny')"

CMD [ "R" ]

