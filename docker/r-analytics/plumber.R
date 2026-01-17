
library(plumber)

#* @get /forecast
function() {
  list(predicted_growth = runif(1, min = 0.1, max = 0.9))
}
