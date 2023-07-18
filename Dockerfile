FROM regnerm/scbreast_2023:1.1.2

# Set global R options
RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install CDI 
RUN R --no-echo --no-restore --no-save -e "remotes::install_github('jichunxie/CDI')"

# Install sc-SHC
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('scry')"
RUN R --no-echo --no-restore --no-save -e "devtools::install_github('igrabski/sc-SHC')"


