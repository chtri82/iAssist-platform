from pyspark.sql import SparkSession
from pyspark.sql.functions import col
import mlflow, mlflow.sklearn
import os
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.datasets import load_iris

spark = SparkSession.builder.appName("iAssist_ETL").getOrCreate()

# Load from Postgres
jdbc_url = "jdbc:postgresql://postgres:5432/iassist"
props = {"user": "admin", "password": "secret", "driver": "org.postgresql.Driver"}
users = spark.read.jdbc(url=jdbc_url, table="users", properties=props)

# Simple transform
clean = users.withColumn("name_upper", col("name").upper())
clean.show()

# MLflow logging
mlflow.set_tracking_uri("http://mlflow:5000")
mlflow.set_experiment("iAssist-Training")

iris = load_iris(as_frame=True)
X_train, X_test, y_train, y_test = train_test_split(iris.data, iris.target)

with mlflow.start_run():
    model = LogisticRegression(max_iter=200)
    model.fit(X_train, y_train)
    acc = model.score(X_test, y_test)
    mlflow.log_metric("accuracy", acc)
    mlflow.sklearn.log_model(model, "model")
    print(f"Model trained: Accuracy = {acc}")
