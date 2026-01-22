library(plumber)
library(jsonlite)
library(DBI)
library(RPostgres)

#* @apiTitle iAssist R Analytics API

# Database connection (adjust credentials if needed)
connect_db <- function() {
  dbConnect(
    RPostgres::Postgres(),
    dbname = "iassist",
    host = "postgres",
    port = 5432,
    user = "admin",
    password = "secret"
  )
}

#* Health check
#* @get /health
function() {
  list(status = "R Analytics API running OK")
}

#* Forecast endpoint
#* @post /forecast
function(req, res) {
  input <- fromJSON(req$postBody)
  forecast <- paste("Predicted value for input", input$value, "is", input$value * 2)
  list(result = forecast)
}

#* Summary endpoint
#* @post /summary
function(req, res) {
  body <- fromJSON(req$postBody)
  numbers <- as.numeric(body$numbers)
  result <- summary(numbers)
  return(result)
}

#* Get recent transactions
#* @get /transactions
function() {
  conn <- connect_db()
  data <- dbGetQuery(conn, "SELECT * FROM user_transactions LIMIT 10;")
  dbDisconnect(conn)
  return(data)
}

#* Add a record to database
#* @post /add_transaction
function(req, res) {
  conn <- connect_db()
  body <- fromJSON(req$postBody)
  dbExecute(
    conn,
    "INSERT INTO user_transactions (user_id, amount, category) VALUES ($1, $2, $3)",
    params = list(body$user_id, body$amount, body$category)
  )
  dbDisconnect(conn)
  list(status = "Transaction inserted successfully")
}
