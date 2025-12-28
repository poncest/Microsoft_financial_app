# ==============================================================================
# data-raw/01_pull_sec_companyfacts.R
# Pull SEC Company Facts (XBRL structured data) for Microsoft
# Author: Steven Ponce
# Purpose: Extract financial statement line items from SEC API
# ==============================================================================

library(httr2)
library(jsonlite)
library(dplyr)
library(purrr)
library(lubridate)
library(fs)
library(here)

# --- Configuration ------------------------------------------------------------

MSFT_CIK <- "0000789019"
SEC_USER_AGENT <- "steven_ponce@yahoo.com"

cache_dir <- here("data-raw", "cache")
dir_create(cache_dir)

# --- Fetch company facts ------------------------------------------------------

companyfacts_url <- glue::glue(
  "https://data.sec.gov/api/xbrl/companyfacts/CIK{MSFT_CIK}.json"
)

cache_file <- path(cache_dir, "msft_companyfacts.json")

if (file_exists(cache_file)) {
  message("Using cached company facts JSON...")
  facts_raw <- read_json(cache_file)
} else {
  message("Fetching company facts from SEC API...")
  
  resp <- request(companyfacts_url) |>
    req_user_agent(SEC_USER_AGENT) |>
    req_retry(max_tries = 3) |>
    req_perform()
  
  facts_raw <- resp_body_json(resp)
  
  # Cache for future runs
  write_json(facts_raw, cache_file, pretty = TRUE, auto_unbox = TRUE)
  message("Cached company facts to: ", cache_file)
}

# --- Extract US-GAAP facts ----------------------------------------------------

usgaap <- facts_raw$facts$`us-gaap`

# Helper: safely convert field to expected type
safe_char <- function(x) {
  if (is.null(x)) return(NA_character_)
  if (is.list(x)) return(NA_character_)
  as.character(x)
}

safe_num <- function(x) {
  if (is.null(x)) return(NA_real_)
  if (is.list(x)) return(NA_real_)
  as.numeric(x)
}

safe_int <- function(x) {
  if (is.null(x)) return(NA_integer_)
  if (is.list(x)) return(NA_integer_)
  as.integer(x)
}

# Helper: convert a single concept's units to tibble (FULLY DEFENSIVE)
extract_concept <- function(concept_name, concept_data) {
  
  # Most financial concepts have USD units
  usd_data <- concept_data$units$USD
  
  if (is.null(usd_data)) return(NULL)
  
  # Process each record individually to handle missing/malformed fields
  records <- map_dfr(usd_data, function(record) {
    tibble(
      concept = concept_name,
      start_date = safe_char(record$start),
      end_date = safe_char(record$end),
      value = safe_num(record$val),
      accn = safe_char(record$accn),
      fy = safe_int(record$fy),
      fp = safe_char(record$fp),
      form = safe_char(record$form),
      filed = safe_char(record$filed)
    )
  })
  
  # Filter out incomplete records
  records |>
    filter(!is.na(end_date), !is.na(value), !is.na(form), !is.na(fp))
}

# Concepts we care about (US-GAAP taxonomy names)
key_concepts <- c(
  # Revenue concepts (Microsoft uses different ones over time)
  "Revenues",  # FY2016-2017
  "RevenueFromContractWithCustomerExcludingAssessedTax",  # FY2018+
  
  # Income statement
  "CostOfRevenue",
  "GrossProfit",
  "OperatingIncomeLoss",
  "NetIncomeLoss",
  "OperatingExpenses",
  "ResearchAndDevelopmentExpense",
  
  # Balance sheet
  "Assets",
  "Liabilities",
  "StockholdersEquity",
  "CashAndCashEquivalentsAtCarryingValue",
  
  # Cash flow
  "NetCashProvidedByUsedInOperatingActivities",
  "NetCashProvidedByUsedInInvestingActivities",
  "NetCashProvidedByUsedInFinancingActivities",
  "PaymentsToAcquirePropertyPlantAndEquipment"  # capex proxy
)

# Extract all concepts
message("\n📥 Extracting financial concepts...")
facts_tidy <- map_dfr(key_concepts, function(concept) {
  if (!is.null(usgaap[[concept]])) {
    message("  ✓ ", concept)
    extract_concept(concept, usgaap[[concept]])
  } else {
    message("  ✗ ", concept, " (not found in data)")
    NULL
  }
})

# --- Filter to annual 10-K filings --------------------------------------------

# Microsoft fiscal year ends June 30
# So FY2023 ends on 2023-06-30, FY2022 ends on 2022-06-30, etc.

facts_annual <- facts_tidy |>
  mutate(
    end_date = ymd(end_date),
    end_year = year(end_date),
    end_month = month(end_date)
  ) |>
  filter(
    form == "10-K",
    fp == "FY",
    end_month == 6,  # Microsoft FY ends in June
    end_year >= 2016,
    end_year <= 2023
  ) |>
  mutate(
    fiscal_year = end_year  # FY2023 = year ending June 30, 2023
  ) |>
  select(fiscal_year, concept, value, end_date, accn, filed) |>
  arrange(fiscal_year, concept)

# --- Quality check ------------------------------------------------------------

message("\n📊 Data extraction summary:")
message("  Total records extracted: ", nrow(facts_tidy))
message("  Annual 10-K records (FY2016-2023): ", nrow(facts_annual))
message("  Unique fiscal years: ", paste(sort(unique(facts_annual$fiscal_year)), collapse = ", "))
message("  Unique concepts: ", n_distinct(facts_annual$concept))

# Detailed breakdown by year
message("\n📅 Records per fiscal year:")
facts_annual |>
  count(fiscal_year) |>
  arrange(fiscal_year) |>
  purrr::pwalk(function(fiscal_year, n) {
    message(sprintf("  FY%d: %d concepts", fiscal_year, n))
  })

# Check for missing key concepts
extracted_concepts <- unique(facts_annual$concept)
missing_concepts <- setdiff(key_concepts, extracted_concepts)

if (length(missing_concepts) > 0) {
  message("\n⚠️  Warning: Missing concepts (not reported or different name):")
  for (mc in missing_concepts) {
    message("  - ", mc)
  }
}

# --- Export cleaned dataset ---------------------------------------------------

output_file <- here("data", "processed", "msft_financials_raw.rds")
dir_create(dirname(output_file))

saveRDS(facts_annual, output_file)
message("\n✅ Saved annual financial facts to: ", output_file)

# Preview
message("\n📋 Sample of extracted data:")
facts_annual |>
  select(fiscal_year, concept, value) |>
  group_by(fiscal_year) |>
  slice_head(n = 3) |>
  ungroup() |>
  print(n = 30)