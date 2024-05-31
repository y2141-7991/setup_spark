from pyspark.sql import SparkSession

spark = SparkSession.\
        builder.\
        appName("pyspark-notebook").\
        master("spark://127.0.0.1:7077").\
        config("spark.driver.host", "localhost").\
        getOrCreate()

import wget

url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
wget.download(url)

data = spark.read.csv("iris.data")

print(data.show())