import pandas as pd

df = pd.read_excel("data/cleaned_marketing_dataset.xlsx")

print("Dataset Loaded Successfully")
print("\nColumns:")
print(df.columns.tolist())

print("\nShape:")
print(df.shape)

print("\nFirst 5 Rows:")
print(df.head())