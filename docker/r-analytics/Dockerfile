FROM r-base:4.3.1

# Install system dependencies required for plumber and jsonlite
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

# Install R packages
RUN R -e "install.packages(c('plumber', 'jsonlite'), repos='https://cloud.r-project.org')"

WORKDIR /app
COPY plumber.R /app/plumber.R

EXPOSE 8000

CMD ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]
