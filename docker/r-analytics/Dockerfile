# Use R base image
FROM r-base:4.3.1

# Install dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev

# Install plumber and jsonlite packages
RUN R -e "install.packages(c('plumber', 'jsonlite'), repos='https://cloud.r-project.org')"

# Set working directory
WORKDIR /app

# Copy the R API file
COPY plumber.R /app/plumber.R

# Expose the port for the R service
EXPOSE 8000

# Run the plumber API
CMD ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]

