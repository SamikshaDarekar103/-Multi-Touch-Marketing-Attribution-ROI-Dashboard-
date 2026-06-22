import pandas as pd

# Load cleaned data
df = pd.read_csv("data/cleaned/cleaned_touchpoints.csv")

# Convert time
df["event_time"] = pd.to_datetime(df["event_time"])

# Sort journeys properly
df = df.sort_values(
    by=["user_id", "user_session", "event_time"]
)

# --------------------------
# First Touch Attribution
# --------------------------
first_touch = df.groupby("user_id").first()

first_touch.to_csv(
    "data/cleaned/first_touch_attribution.csv"
)

print("First touch completed")

# --------------------------
# Last Touch Attribution
# --------------------------
last_touch = df.groupby("user_id").last()

last_touch.to_csv(
    "data/cleaned/last_touch_attribution.csv"
)

print("Last touch completed")

# --------------------------
# Linear Attribution
# --------------------------
touch_counts = df.groupby("user_id").size().reset_index(name="touch_count")

linear = df.merge(
    touch_counts,
    on="user_id"
)

linear["credit"] = 1 / linear["touch_count"]

linear.to_csv(
    "data/cleaned/linear_attribution.csv",
    index=False
)

print("Linear attribution completed")