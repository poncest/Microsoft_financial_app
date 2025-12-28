# ==============================================================================
# Runtime Setup (Safe for Deployment)
# Author: Steven Ponce
# Purpose: Constants, options, and helpers — NO INSTALLATIONS
# ==============================================================================

# --- Color Palette (Professional, Corporate) ----------------------------------

msft_colors <- list(
  # Primary brand
  primary   = "#0078D4",  # Microsoft Blue
  secondary = "#50E6FF",  # Light Blue (accent)
  
  # Segments (distinct, professional)
  cloud     = "#0078D4",  # Blue (Intelligent Cloud)
  productivity = "#107C10", # Green (Productivity)
  personal  = "#FFB900",  # Gold (More Personal Computing)
  
  # Status/context
  success   = "#107C10",  # Green
  warning   = "#FFB900",  # Gold
  danger    = "#E81123",  # Red
  
  # UI foundation
  dark      = "#243A5E",  # Dark Blue (headers)
  medium    = "#605E5C",  # Medium Gray (text)
  light     = "#F3F2F1",  # Light Gray (backgrounds)
  white     = "#FFFFFF",
  
  # Chart palette (for multi-line trends)
  chart_1   = "#0078D4",  # Blue
  chart_2   = "#107C10",  # Green
  chart_3   = "#FFB900",  # Gold
  chart_4   = "#E81123",  # Red
  chart_5   = "#8764B8"   # Purple
)

# --- ggplot2 Theme (Consulting-Grade) -----------------------------------------

theme_msft <- function(base_size = 12) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = base_size * 1.3, 
                                         color = msft_colors$dark),
      plot.subtitle = ggplot2::element_text(color = msft_colors$text, 
                                            margin = ggplot2::margin(b = 10)),
      axis.title = ggplot2::element_text(face = "bold", color = msft_colors$text),
      axis.text = ggplot2::element_text(color = msft_colors$text),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(color = "#E1DFDD", linewidth = 0.3),
      legend.position = "top",
      legend.title = ggplot2::element_text(face = "bold", size = base_size * 0.9),
      plot.background = ggplot2::element_rect(fill = "white", color = NA),
      panel.background = ggplot2::element_rect(fill = "white", color = NA)
    )
}

# --- Number Formatting Helpers ------------------------------------------------

fmt_currency <- function(x, prefix = "$", suffix = "", digits = 0) {
  scales::label_dollar(
    prefix = prefix,
    suffix = suffix,
    scale = 1e-9,  # Billions
    accuracy = 10^-digits
  )(x)
}

fmt_percent <- function(x, digits = 1) {
  scales::label_percent(accuracy = 0.1^digits)(x)
}

fmt_number <- function(x, suffix = "", scale = 1, digits = 1) {
  scales::label_number(
    suffix = suffix,
    scale = scale,
    accuracy = 0.1^digits
  )(x)
}

# --- Shiny Options (Performance & UX) -----------------------------------------

options(
  shiny.maxRequestSize = 30 * 1024^2,  # 30MB upload limit
  spinner.type = 4,                     # Loading spinner style
  spinner.color = msft_colors$primary
)

