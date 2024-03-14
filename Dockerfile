FROM regnerm/scbreast_2023:1.8.0

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

# Install depmap and ExperimentHub
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('depmap')"
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('ExperimentHub')"

# Install BSDA
RUN R --no-echo --no-restore --no-save -e "install.packages('BSDA')"
