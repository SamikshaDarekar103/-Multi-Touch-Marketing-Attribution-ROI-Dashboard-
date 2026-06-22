import pandas as pd

df = pd.read_csv("data/raw/2019-Oct.csv",nrows=1000)

print(df.head())
print(df.shape)