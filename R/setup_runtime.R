# R/setup_runtime.R
# Microsoft Financial Dashboard - Runtime Configuration
# Professional, executive-grade styling for financial analysis

# ==============================================================================
# APP METADATA
# ==============================================================================
APP_TITLE <- "Microsoft Financial Analysis"
APP_SUBTITLE <- "Strategic Financial Analysis (FY2016-FY2023)"
APP_VERSION <- "1.0.0"

# ==============================================================================
# PROFESSIONAL COLOR PALETTE (Simplified for Executive Dashboard)
# ==============================================================================
msft_colors <- list(
  # Primary Microsoft colors
  primary = "#0078D4",          # Microsoft Blue
  dark = "#004578",             # Deep Blue (headers, text)
  medium = "#106EBE",           # Medium Blue
  light = "#E1F5FE",            # Light Blue (backgrounds)
  
  # Supporting colors (limited palette)
  success = "#0078D4",    
  warning = "#0078D4", 
  danger = "#D13438",           # Red (negative)
  
  # Text colors
  text_dark = "#323130",        # Near black
  text_medium = "#605E5C",      # Medium gray
  text_light = "#8A8886",       # Light gray
  
  # Background colors
  background = "#FAF9F8",       # Off-white
  card_bg = "#FFFFFF",          # Pure white
  
  # Chart colors (max 3 for multi-series)
  chart_1 = "#0078D4",          # Primary blue
  chart_2 = "#50E6FF",          # Cyan
  chart_3 = "#8764B8",          # Purple
  
  # Segment-specific colors (for Growth & Mix tab)
  cloud = "#0078D4",            # Intelligent Cloud - Primary blue
  productivity = "#50E6FF",     # Productivity - Cyan
  personal = "#8764B8",         # Personal Computing - Purple
  
  # Accent
  accent = "#FFB900"            # Gold (highlights)
)

# ==============================================================================
# GGPLOT2 THEME (Professional, consulting-grade)
# ==============================================================================
theme_msft <- function(base_size = 12, base_family = "") {
  ggplot2::theme_minimal(base_size = base_size, base_family = base_family) +
    ggplot2::theme(
      # Text
      text = ggplot2::element_text(color = msft_colors$text_dark),
      plot.title = ggplot2::element_text(
        size = base_size * 1.2,
        face = "bold",
        color = msft_colors$dark,
        margin = ggplot2::margin(b = 10)
      ),
      plot.subtitle = ggplot2::element_text(
        size = base_size * 0.95,
        color = msft_colors$text_medium,
        margin = ggplot2::margin(b = 15)
      ),
      
      # Axes
      axis.title = ggplot2::element_text(
        size = base_size * 0.9,
        color = msft_colors$text_dark,
        face = "bold"
      ),
      axis.text = ggplot2::element_text(
        size = base_size * 0.85,
        color = msft_colors$text_medium
      ),
      axis.line = ggplot2::element_line(color = "#E1DFDD", linewidth = 0.5),
      axis.ticks = ggplot2::element_line(color = "#E1DFDD"),
      
      # Grid
      panel.grid.major = ggplot2::element_line(color = "#F3F2F1", linewidth = 0.3),
      panel.grid.minor = ggplot2::element_blank(),
      
      # Legend
      legend.position = "bottom",
      legend.title = ggplot2::element_text(size = base_size * 0.9, face = "bold"),
      legend.text = ggplot2::element_text(size = base_size * 0.85),
      legend.background = ggplot2::element_rect(fill = "white", color = NA),
      
      # Panel
      panel.background = ggplot2::element_rect(fill = "white", color = NA),
      plot.background = ggplot2::element_rect(fill = "white", color = NA),
      
      # Margins
      plot.margin = ggplot2::margin(t = 10, r = 15, b = 10, l = 10)
    )
}

# ==============================================================================
# GGIRAPH OPTIONS (Interactive tooltips styling)
# ==============================================================================
GGIRAPH_OPTS <- list(
  opts_tooltip = ggiraph::opts_tooltip(
    css = paste0(
      "background-color:", msft_colors$card_bg, ";",
      "color:", msft_colors$text_dark, ";",
      "padding: 10px;",
      "border-radius: 4px;",
      "box-shadow: 0 2px 8px rgba(0,0,0,0.15);",
      "font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;",
      "font-size: 13px;",
      "border: 1px solid #E1DFDD;"
    ),
    opacity = 0.95,
    use_fill = FALSE,
    use_stroke = FALSE
  ),
  opts_hover = ggiraph::opts_hover(
    css = "fill-opacity: 0.8; stroke-width: 2;"
  ),
  opts_sizing = ggiraph::opts_sizing(rescale = TRUE, width = 1)
)

# ==============================================================================
# NUMBER FORMATTING HELPERS
# ==============================================================================

#' Format currency (optimized for billions)
#' @param x Numeric value
#' @param suffix Unit suffix (e.g., "B", "M")
#' @param scale Scaling factor (1e-9 for billions, 1e-6 for millions)
#' @param digits Number of decimal places
fmt_currency <- function(x, suffix = "B", scale = 1e-9, digits = 1) {
  scaled <- x * scale
  paste0("$", format(round(scaled, digits), nsmall = digits, big.mark = ","), suffix)
}

#' Format percentage
#' @param x Numeric value (e.g., 0.123 for 12.3%)
#' @param digits Number of decimal places
#' @param include_sign Include + sign for positive values
fmt_percent <- function(x, digits = 1, include_sign = FALSE) {
  # Vectorized sign handling
  if (include_sign) {
    sign_vec <- ifelse(x > 0, "+", "")
  } else {
    sign_vec <- ""
  }
  
  pct_val <- round(x * 100, digits)
  paste0(sign_vec, format(pct_val, nsmall = digits), "%")
}

#' Format number with commas
#' @param x Numeric value
#' @param digits Number of decimal places
fmt_number <- function(x, digits = 0) {
  format(round(x, digits), nsmall = digits, big.mark = ",")
}

#' Format large numbers with K/M/B suffix
#' @param x Numeric value
#' @param digits Number of decimal places
fmt_large <- function(x, digits = 1) {
  if (abs(x) >= 1e9) {
    paste0(format(round(x / 1e9, digits), nsmall = digits), "B")
  } else if (abs(x) >= 1e6) {
    paste0(format(round(x / 1e6, digits), nsmall = digits), "M")
  } else if (abs(x) >= 1e3) {
    paste0(format(round(x / 1e3, digits), nsmall = digits), "K")
  } else {
    format(round(x, digits), nsmall = digits)
  }
}

# ==============================================================================
# CONSTANTS
# ==============================================================================
YEAR_START <- 2016
YEAR_END <- 2023

# Data source attribution
DATA_SOURCE <- "Source: SEC EDGAR XBRL Company Facts API | Microsoft Corporation (CIK 0000789019)"

# Disclaimer text
DATA_DISCLAIMER <- paste(
  "Note: This is a portfolio project demonstrating financial analysis and dashboard design.",
  "Figures are simplified from SEC filings for analytical purposes.",
  "This analysis does not constitute investment advice or official company reporting."
)