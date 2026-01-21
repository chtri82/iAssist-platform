FROM r-base:4.3.1

# Install plumber and any dependencies
RUN R -e "install.packages('plumber', repos='https://cloud.r-project.org')"

WORKDIR /app
COPY plumber.R /app/plumber.R

EXPOSE 8000
CMD ["R", "-e", "pr <- plumber::plumb('plumber.R'); pr$run(host='0.0.0.0', port=8000)"]

