import pandas as pd

# Load Dataset
df = pd.read_excel("data/cleaned_marketing_dataset.xlsx")

print("Original Shape:", df.shape)

# Check Missing Values
print("\nMissing Values:")
print(df.isnull().sum())

# Remove Duplicates
df = df.drop_duplicates()

# Convert Timestamp
df["Timestamp"] = pd.to_datetime(df["Timestamp"])

print("\nNew Shape:", df.shape)

# Save Clean Data
df.to_csv(
    "outputs/clean_marketing_data.csv",
    index=False
)

print("\nCleaned dataset saved successfully!")