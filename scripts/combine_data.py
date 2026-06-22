import pandas as pd

chunk_size = 100000

output_file = "data/raw/ecommerce_behavior.csv"

# First file
first = True

for file in ["data/raw/2019-Oct.csv", "data/raw/2019-Nov.csv"]:
    for chunk in pd.read_csv(file, chunksize=chunk_size):
        chunk.to_csv(
            output_file,
            mode="w" if first else "a",
            index=False,
            header=first
        )
        first = False

print("Files combined successfully")