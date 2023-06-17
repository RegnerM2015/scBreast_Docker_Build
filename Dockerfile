FROM regnerm/scbreast_2023:1.1.1

# Set global R options
RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install openxlsx
RUN R --no-echo --no-restore --no-save -e "install.packages('openxlsx')"



