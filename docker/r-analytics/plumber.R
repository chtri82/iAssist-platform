library(plumber)
library(jsonlite)

#* @post /forecast
function(req, res) {
  input <- fromJSON(req$postBody)
  forecast <- paste("Predicted value for input", input$value, "is", input$value * 2)
  list(result = forecast)
}

