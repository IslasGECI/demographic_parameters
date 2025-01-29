FROM islasgeci/base:1.0.0
COPY . /workdir

RUN R -e "install.packages('comprehenr', repos = 'http://cran.rstudio.com')"
RUN R -e "remotes::install_github('IslasGECI/testtools')"
RUN R -e "devtools::install_version('rjson', version = '0.2.21',repos='http://cran.rstudio.com')"
