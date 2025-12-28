# ==============================================================================
# Global Setup - Packages, Data, Runtime Config
# Author: Steven Ponce
# ==============================================================================

# --- Packages -----------------------------------------------------------------

library(shiny)
library(shiny.semantic)
library(semantic.dashboard)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggiraph)
library(scales)
library(reactable)
library(here)

# --- Runtime Setup ------------------------------------------------------------

source(here("R", "setup_runtime.R"))

# --- Load Data ----------------------------------------------------------------

# Financial summary (FY2016-2023)
financials <- readRDS(here("data", "processed", "msft_financials_fy.rds"))

# Segment revenue
segments <- readRDS(here("data", "processed", "msft_segment_revenue.rds"))

# --- Derived Metrics (App-Specific) -------------------------------------------

# Calculate additional metrics for charts
financials <- financials |>
  mutate(
    # Revenue per dollar of assets (H4)
    revenue_per_asset = revenue / total_assets,
    
    # FCF margin
    fcf_margin = fcf_proxy / revenue,
    
    # R&D intensity
    rnd_intensity = rnd / revenue
  )

# Calculate CAGR for periods (H1)
cagr_early <- (financials$revenue[financials$fiscal_year == 2019] / 
                 financials$revenue[financials$fiscal_year == 2016])^(1/3) - 1

cagr_late <- (financials$revenue[financials$fiscal_year == 2023] / 
                financials$revenue[financials$fiscal_year == 2020])^(1/3) - 1

# Store for use in app
app_metrics <- list(
  cagr_early = cagr_early,
  cagr_late = cagr_late
)

# --- Source Components (CRITICAL ORDER) ---------------------------------------

# MUST source in this order:
# 1. Chart functions (used by server)
# 2. Tab definitions (used by ui_main)
# 3. UI main structure (creates 'ui' object)
# (server.R is sourced by app.R, not here)

source("server_charts.R")  # Chart functions
source("ui_tabs.R")        # Tab definitions  
source("ui_main.R")        # Creates 'ui' object ← CRITICAL

message("✅ Global setup complete")
message("  Financial data: ", nrow(financials), " years")
message("  Segment data: ", nrow(segments), " records")