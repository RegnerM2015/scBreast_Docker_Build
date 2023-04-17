FROM regnerm/scbreast_2023:1.0.5

# Set global R options
RUN echo "options(repos = 'https://cloud.r-project.org')" > $(R --no-echo --no-save -e "cat(Sys.getenv('R_HOME'))")/etc/Rprofile.site
ENV RETICULATE_MINICONDA_ENABLED=FALSE

# Install MatrixEQTL
RUN R --no-echo --no-restore --no-save -e "install.packages('MatrixEQTL')"

# Install dependencies for lme4 and lmerTest
RUN apt-get install -y \
  cmake \
  protobuf-compiler \
  libgfortran5 


# Install lme4, lmerTest, and dependencies
RUN R --no-echo --no-restore --no-save -e "install.packages('lme4', dependencies = TRUE)"
RUN R --no-echo --no-restore --no-save -e "install.packages('lmerTest', dependencies = TRUE)"
