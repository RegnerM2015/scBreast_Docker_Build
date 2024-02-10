FROM regnerm/scbreast_2023:1.1.2

# Set global R options
RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install lib and other dependencies
RUN apt-get update
RUN apt-get install -y \
    libproj-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libtiff-dev

# Install grr 
RUN R --no-echo --no-restore --no-save -e "install.packages('grr')"

# Install clusterProfiler, enrichplot, and ggtree 
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('YuLab-SMU/ggtree')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('enrichplot')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('clusterProfiler')"

# Install EnhancedVolcano
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('EnhancedVolcano')"

# Install sigclust2
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('pkimes/sigclust2')"

# Install eulerr
RUN R --no-echo --no-restore --no-save -e "install.packages('eulerr')"

# Install writexl
RUN R --no-echo --no-restore --no-save -e "install.packages('writexl')"
