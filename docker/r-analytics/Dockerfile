# Use the official R base image
FROM r-base:4.3.1

# Install Linux dependencies for R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libsodium-dev \
    && apt-get clean

# Install required R packages from CRAN
RUN R -e "install.packages(c('plumber', 'jsonlite', 'DBI', 'RPostgres'), repos='https://cloud.r-project.org/')"

# Create the app directory
WORKDIR /app

# Copy your Plumber API file into the container
COPY plumber.R /app/plumber.R

# Expose the port Plumber will run on
EXPOSE 8000

# Run the Plumber API when the container starts
CMD ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]
