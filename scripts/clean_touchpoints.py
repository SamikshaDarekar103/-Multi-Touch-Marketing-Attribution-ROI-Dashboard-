import pandas as pd

# Read only first 100,000 rows
df = pd.read_csv(
    "data/raw/ecommerce_behavior.csv",
    nrows=100000,
    low_memory=False
)

print("Original shape:", df.shape)

# Remove duplicates
df.drop_duplicates(inplace=True)

# Remove missing sessions
df.dropna(subset=["user_session"], inplace=True)

# Convert event time
df["event_time"] = pd.to_datetime(df["event_time"])

# Sort customer journey
df.sort_values(
    by=["user_id", "user_session", "event_time"],
    inplace=True
)

# Save cleaned data
df.to_csv(
    "data/cleaned/cleaned_touchpoints.csv",
    index=False
)

print("Cleaning completed")
print("Final shape:", df.shape)

print("\nColumns:")
print(df.columns)