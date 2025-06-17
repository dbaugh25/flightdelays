# Load necessary libraries
library(tidyverse)

# Set path to your raw CSV file
raw_path <- "data/raw/your_filename.csv"  # replace with actual filename

# Read the data
df <- read_csv(raw_path)

# Step 1: Filter flights where JFK is either origin or destination
df_jfk <- df %>%
  filter(Origin == "JFK" | Dest == "JFK")

# Step 2: Remove canceled flights
df_jfk <- df_jfk %>%
  filter(Cancelled == 0)

# Step 3: Create binary target: 1 if arrival OR departure delay > 15 mins
df_jfk <- df_jfk %>%
  mutate(
    delayed_15 = if_else(DepDelay > 15 | ArrDelay > 15, 1, 0)
  )

# Optional: drop any rows with missing delays (just in case)
df_jfk <- df_jfk %>%
  drop_na(DepDelay, ArrDelay)

# Step 4: Save cleaned file
write_csv(df_jfk, "data/cleaned/jfk_flights_cleaned.csv")

# Optional: Print quick summary
cat("✅ Cleaned JFK dataset saved. Total rows:", nrow(df_jfk), "\n")
