# h/t colin fay for worked example of minimal dockerfile for
# r users

FROM rocker/r-ver:3.4.4

ARG WHEN

RUN mkdir /home/analysis /home/results

RUN R -e "options(repos = \
    list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/${WHEN}')); \
    install.packages(c('leaflet','readr','tibble','htmlwidgets'))"

# copy local to container.
COPY myscript.R /home/analysis/myscript.R

# mv container results to local
CMD cd /home/analysis \
    && R -e "source('myscript.R')" \
    && mv /home/analysis/m.* /home/results/

# to build
#   docker build --build-arg WHEN=2019-01-06 -t analysis .
#   #docker build --build-arg WHEN=2019-04-15 -t analysis .

# to run / export docker -> local
#  docker run -v ~/mydocker/results:/home/results  analysis 
