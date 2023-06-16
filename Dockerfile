FROM regnerm/scbreast_2023:1.1.0

# Set global R options
RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install BSgenome hg19
RUN R --no-echo --no-restore --no-save -e "BiocManager::install('BSgenome.Hsapiens.UCSC.hg19')"

# Update ArchR version
RUN R --no-echo --no-restore --no-save -e "utils::remove.packages('ArchR')"
RUN R --no-echo --no-restore --no-save -e "devtools::install_github('GreenleafLab/ArchR', ref='master', repos = BiocManager::repositories())"

