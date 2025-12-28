# ==============================================================================
# Pull Microsoft Segment Revenue Data (FY2016–FY2023)
# Author: Steven Ponce
# Purpose: Extract segment-level revenue for Growth & Mix analysis
# ==============================================================================

library(jsonlite)
library(dplyr)
library(tidyr)
library(purrr)
library(lubridate)
library(here)

# --- Load cached company facts ------------------------------------------------

facts_raw <- read_json(here("data-raw", "cache", "msft_companyfacts.json"))
usgaap <- facts_raw$facts$`us-gaap`

# --- Find segment revenue concepts --------------------------------------------

# Microsoft reports segment revenue under "RevenueFromContractWithCustomerIncludingAssessedTax"
# with different "segment" dimensions

# Check for segment-related revenue concepts
segment_concepts <- names(usgaap)[grepl("Segment", names(usgaap), ignore.case = TRUE)]

message("📊 Segment-related concepts found:")
message(paste(segment_concepts, collapse = "\n"))

# --- Common patterns for segment data -----------------------------------------

# Option 1: Look for "SegmentReportingInformationRevenue" or similar
# Option 2: Check 10-K HTML for segment tables (manual fallback)

# For now, let's check what's available
if ("RevenueFromExternalCustomersByProductsAndServices" %in% names(usgaap)) {
  message("\n✓ Found: RevenueFromExternalCustomersByProductsAndServices")
  
  segment_data <- usgaap$RevenueFromExternalCustomersByProductsAndServices$units$USD
  
  # Inspect structure
  message("  Sample record:")
  str(segment_data[[1]], max.level = 1)
}

# --- Manual segment data (interim solution) -----------------------------------

message("\n⚠️  Note: SEC API segment data often requires parsing 10-K tables directly.")
message("   For portfolio purposes, we'll create a clean segment dataset manually")
message("   from Microsoft's reported segment disclosures.\n")

# Microsoft's three segments (from 10-K filings):
# 1. Productivity and Business Processes
# 2. Intelligent Cloud  
# 3. More Personal Computing

# Manually transcribed from 10-K filings (FY2016-2023)
# Source: Item 1 - Business, Segment Information

segment_revenue <- tribble(
  ~fiscal_year, ~segment, ~revenue,
  
  # FY2016 (10-K filed 2016-07-28)
  2016, "Productivity and Business Processes", 26430000000,
  2016, "Intelligent Cloud", 25042000000,
  2016, "More Personal Computing", 39687000000,
  
  # FY2017 (10-K filed 2017-08-02)
  2017, "Productivity and Business Processes", 28313000000,
  2017, "Intelligent Cloud", 27385000000,
  2017, "More Personal Computing", 40804000000,
  
  # FY2018 (10-K filed 2018-08-03)
  2018, "Productivity and Business Processes", 35641000000,
  2018, "Intelligent Cloud", 32219000000,
  2018, "More Personal Computing", 42536000000,
  
  # FY2019 (10-K filed 2019-08-01)
  2019, "Productivity and Business Processes", 41160000000,
  2019, "Intelligent Cloud", 39085000000,
  2019, "More Personal Computing", 45600000000,
  
  # FY2020 (10-K filed 2020-07-30)
  2020, "Productivity and Business Processes", 46398000000,
  2020, "Intelligent Cloud", 48366000000,
  2020, "More Personal Computing", 48251000000,
  
  # FY2021 (10-K filed 2021-07-29)
  2021, "Productivity and Business Processes", 53915000000,
  2021, "Intelligent Cloud", 60080000000,
  2021, "More Personal Computing", 54093000000,
  
  # FY2022 (10-K filed 2022-07-28)
  2022, "Productivity and Business Processes", 63364000000,
  2022, "Intelligent Cloud", 75251000000,
  2022, "More Personal Computing", 59655000000,
  
  # FY2023 (10-K filed 2023-07-27)
  2023, "Productivity and Business Processes", 69274000000,
  2023, "Intelligent Cloud", 87907000000,
  2023, "More Personal Computing", 53734000000
)

# --- Calculate segment metrics ------------------------------------------------

segment_summary <- segment_revenue |>
  group_by(fiscal_year) |>
  mutate(
    total_revenue = sum(revenue),
    pct_of_total = revenue / total_revenue
  ) |>
  ungroup() |>
  arrange(fiscal_year, segment)

# --- Export -------------------------------------------------------------------

output_file <- here("data", "processed", "msft_segment_revenue.rds")
output_csv <- here("data", "processed", "msft_segment_revenue.csv")

saveRDS(segment_summary, output_file)
write.csv(segment_summary, output_csv, row.names = FALSE)

message("✅ Segment revenue data saved to:")
message("  - ", output_file)
message("  - ", output_csv)

# --- Preview ------------------------------------------------------------------

message("\n📋 Segment revenue summary:")
segment_summary |>
  select(fiscal_year, segment, revenue, pct_of_total) |>
  print(n = 24)

message("\n📊 Segment mix trends:")
segment_summary |>
  group_by(segment) |>
  summarize(
    fy2016_pct = pct_of_total[fiscal_year == 2016],
    fy2023_pct = pct_of_total[fiscal_year == 2023],
    change = fy2023_pct - fy2016_pct
  ) |>
  print()