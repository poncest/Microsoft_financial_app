# Microsoft Financial Analysis Dashboard - Global Setup
# Loads packages, data, and modules

# ==============================================================================
# 1. Package Loading
# ==============================================================================

suppressPackageStartupMessages({
  # Core Shiny
  library(shiny)
  library(shiny.semantic)
  library(semantic.dashboard)
  library(shinyjs)
  library(waiter)
  
  # Data manipulation
  library(dplyr)
  library(tidyr)
  
  # Visualization
  library(ggplot2)
  library(ggiraph)
  library(reactable)
  library(scales)
  
  # Utilities
  library(forcats)
  library(here)
  library(cpp11)
})

# ==============================================================================
# 2. Helper Functions & Theme
# ==============================================================================

source(here("R", "setup_runtime.R"))

# ==============================================================================
# 3. Load Data
# ==============================================================================

# Financial data (annual, wide format)
financials <- readRDS(here("data", "processed", "msft_financials_fy.rds"))

# Segment revenue data
segments <- readRDS(here("data", "processed", "msft_segment_revenue.rds"))

# ==============================================================================
# 4. Derived Metrics (Add Calculated Columns)
# ==============================================================================

# Add derived metrics to financials data
financials <- financials |>
  mutate(
    # Revenue per dollar of assets (H4)
    revenue_per_asset = revenue / total_assets,
    
    # FCF margin
    fcf_margin = fcf_proxy / revenue,
    
    # R&D intensity
    rnd_intensity = rnd / revenue
  )

# ==============================================================================
# 5. App-Level Metrics (Used Across Multiple Tabs)
# ==============================================================================

# Calculate CAGRs for hypothesis testing
cagr_early <- (financials$revenue[financials$fiscal_year == 2019] / 
                 financials$revenue[financials$fiscal_year == 2016])^(1/3) - 1

cagr_late <- (financials$revenue[financials$fiscal_year == 2023] / 
                financials$revenue[financials$fiscal_year == 2020])^(1/3) - 1

# Store key metrics for use in modules
app_metrics <- list(
  # CAGRs
  cagr_early = cagr_early,
  cagr_late = cagr_late,
  
  # Latest year values
  latest_year = max(financials$fiscal_year),
  latest_revenue = financials |> filter(fiscal_year == max(fiscal_year)) |> pull(revenue),
  latest_operating_margin = financials |> filter(fiscal_year == max(fiscal_year)) |> pull(operating_margin),
  latest_fcf = financials |> filter(fiscal_year == max(fiscal_year)) |> pull(fcf_proxy),
  latest_fcf_margin = financials |> filter(fiscal_year == max(fiscal_year)) |> pull(fcf_margin),
  latest_revenue_growth = financials |> filter(fiscal_year == max(fiscal_year)) |> pull(revenue_growth),
  
  # Range values
  year_range = range(financials$fiscal_year),
  revenue_range = range(financials$revenue)
)

# ==============================================================================
# 5. Load Chart Functions
# ==============================================================================

source(here("R", "charts.R"))

# ==============================================================================
# 6. Load Modules
# ==============================================================================

source(here("modules", "mod_executive_brief.R"))
source(here("modules", "mod_growth_mix.R"))
source(here("modules", "mod_profitability.R"))
source(here("modules", "mod_cash_engine.R"))
source(here("modules", "mod_balance_sheet.R"))
source(here("modules", "mod_data_explorer.R"))