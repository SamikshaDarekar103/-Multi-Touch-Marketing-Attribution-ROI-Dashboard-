import pandas as pd

df = pd.read_csv("outputs/clean_marketing_data.csv")

# Sort by user and time
df = df.sort_values(
    ["User_ID", "Timestamp"]
)

# Create journey path
journey = (
    df.groupby("User_ID")["UTM_Source"]
      .apply(lambda x: " -> ".join(x))
      .reset_index()
)

journey.columns = [
    "User_ID",
    "Customer_Journey"
]

print(journey.head())

# Save
journey.to_csv(
    "outputs/customer_journey.csv",
    index=False
)

print("\nCustomer Journey File Created")