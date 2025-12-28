# ==============================================================================
# data-raw/02_build_financials_fy.R
# Build consolidated financial summary table (FY2016–FY2023)
# Author: Steven Ponce
# Purpose: Derive margins, growth rates, cash flow metrics
# ==============================================================================

library(dplyr)
library(tidyr)
library(here)

# --- Load raw facts -----------------------------------------------------------

facts <- readRDS(here("data", "processed", "msft_financials_raw.rds"))

message("\n📥 Loaded raw financial facts:")
message("  Rows: ", nrow(facts))
message("  Fiscal years: ", paste(sort(unique(facts$fiscal_year)), collapse = ", "))
message("  Concepts: ", n_distinct(facts$concept))

# --- Handle duplicates (take most recent filing per concept per year) --------

facts_dedup <- facts |>
  arrange(fiscal_year, concept, desc(filed)) |>
  group_by(fiscal_year, concept) |>
  slice_head(n = 1) |>
  ungroup()

message("\n🔧 After deduplication:")
message("  Rows: ", nrow(facts_dedup))

# --- Pivot to wide format (one row per FY) -----------------------------------

financials <- facts_dedup |>
  select(fiscal_year, concept, value) |>
  pivot_wider(
    names_from = concept,
    values_from = value,
    values_fn = first  # safety net for any remaining duplicates
  )

message("\n📊 Pivoted to wide format:")
message("  Rows: ", nrow(financials))
message("  Columns: ", ncol(financials))

# --- Rename columns to friendlier names ---------------------------------------

financials <- financials |>
  rename_with(
    ~case_when(
      . == "CostOfRevenue" ~ "cogs",
      . == "GrossProfit" ~ "gross_profit",
      . == "OperatingIncomeLoss" ~ "operating_income",
      . == "NetIncomeLoss" ~ "net_income",
      . == "OperatingExpenses" ~ "opex",
      . == "ResearchAndDevelopmentExpense" ~ "rnd",
      . == "Assets" ~ "total_assets",
      . == "Liabilities" ~ "total_liabilities",
      . == "StockholdersEquity" ~ "shareholders_equity",
      . == "CashAndCashEquivalentsAtCarryingValue" ~ "cash",
      . == "NetCashProvidedByUsedInOperatingActivities" ~ "cfo",
      . == "NetCashProvidedByUsedInInvestingActivities" ~ "cfi",
      . == "NetCashProvidedByUsedInFinancingActivities" ~ "cff",
      . == "PaymentsToAcquirePropertyPlantAndEquipment" ~ "capex",
      TRUE ~ .
    )
  )

# --- Consolidate revenue concepts (handle accounting standard change) --------

# Microsoft switched from "Revenues" to "RevenueFromContractWithCustomerExcludingAssessedTax" around FY2018
# Merge these into a single "revenue" column

if ("RevenueFromContractWithCustomerExcludingAssessedTax" %in% names(financials)) {
  financials <- financials |>
    rename(revenue_new = RevenueFromContractWithCustomerExcludingAssessedTax)
}

if ("Revenues" %in% names(financials)) {
  financials <- financials |>
    rename(revenue_old = Revenues)
}

# Combine into single revenue column
if (all(c("revenue_old", "revenue_new") %in% names(financials))) {
  message("\n💡 Consolidating revenue from two concepts (accounting standard change)")
  financials <- financials |>
    mutate(revenue = coalesce(revenue_new, revenue_old)) |>
    select(-revenue_old, -revenue_new)
} else if ("revenue_old" %in% names(financials)) {
  financials <- financials |>
    rename(revenue = revenue_old)
} else if ("revenue_new" %in% names(financials)) {
  financials <- financials |>
    rename(revenue = revenue_new)
}

# --- Derive revenue if missing (gross_profit + cogs) --------------------------

if (!"revenue" %in% names(financials) && all(c("gross_profit", "cogs") %in% names(financials))) {
  message("\n💡 Deriving revenue from gross_profit + cogs")
  financials <- financials |>
    mutate(revenue = gross_profit + cogs)
}

# --- Derive calculated metrics ------------------------------------------------

# Check which columns exist
has_revenue <- "revenue" %in% names(financials)
has_gross_profit <- "gross_profit" %in% names(financials)
has_operating_income <- "operating_income" %in% names(financials)
has_net_income <- "net_income" %in% names(financials)
has_cfo <- "cfo" %in% names(financials)
has_capex <- "capex" %in% names(financials)
has_liabilities <- "total_liabilities" %in% names(financials)
has_equity <- "shareholders_equity" %in% names(financials)
has_cash <- "cash" %in% names(financials)
has_assets <- "total_assets" %in% names(financials)

# Calculate metrics only if required columns exist
financials <- financials |>
  mutate(
    # Margins
    gross_margin = if (has_revenue && has_gross_profit) gross_profit / revenue else NA_real_,
    operating_margin = if (has_revenue && has_operating_income) operating_income / revenue else NA_real_,
    net_margin = if (has_revenue && has_net_income) net_income / revenue else NA_real_,
    
    # Cash flow
    fcf_proxy = if (has_cfo && has_capex) cfo - capex else NA_real_,
    
    # Growth rates (YoY)
    revenue_growth = if (has_revenue) (revenue / lag(revenue)) - 1 else NA_real_,
    operating_income_growth = if (has_operating_income) (operating_income / lag(operating_income)) - 1 else NA_real_,
    net_income_growth = if (has_net_income) (net_income / lag(net_income)) - 1 else NA_real_,
    
    # Balance sheet ratios
    debt_to_equity = if (has_liabilities && has_equity) total_liabilities / shareholders_equity else NA_real_,
    cash_to_assets = if (has_cash && has_assets) cash / total_assets else NA_real_
  ) |>
  arrange(fiscal_year)

# --- Export final table -------------------------------------------------------

output_rds <- here("data", "processed", "msft_financials_fy.rds")
output_csv <- here("data", "processed", "msft_financials_fy.csv")

saveRDS(financials, output_rds)
write.csv(financials, output_csv, row.names = FALSE)

message("\n✅ Financial summary saved to:")
message("  - ", output_rds)
message("  - ", output_csv)

# --- Preview ------------------------------------------------------------------

message("\n📋 Preview of final dataset:")
message("  Fiscal years: ", paste(sort(financials$fiscal_year), collapse = ", "))

# Show available columns
message("\n📊 Available columns:")
message("  ", paste(names(financials), collapse = ", "))

# Preview key metrics
message("\n📈 Sample data (first 3 years):")
financials |>
  select(fiscal_year, any_of(c("revenue", "gross_margin", "operating_margin", "net_margin", "fcf_proxy"))) |>
  head(3) |>
  print()

message("\n🎉 Data preparation complete!\n")