# ==============================================================================
# Server - Chart Building Functions
# Author: Steven Ponce
# ==============================================================================

# --- Executive Brief Chart ----------------------------------------------------

chart_executive_trend <- function(data) {
  
  # Prepare data
  plot_data <- data |>
    select(fiscal_year, revenue, operating_margin) |>
    mutate(
      revenue_b = revenue / 1e9,  # Convert to billions for display
      tooltip_revenue = paste0(
        "FY", fiscal_year, "\n",
        "Revenue: ", fmt_currency(revenue, suffix = "B", scale = 1e-9, digits = 1), "\n",
        "Op Margin: ", fmt_percent(operating_margin, digits = 1)
      )
    )
  
  # Create plot
  p <- ggplot(plot_data, aes(x = fiscal_year)) +
    
    # Revenue bars
    geom_col_interactive(
      aes(y = revenue_b, tooltip = tooltip_revenue, data_id = fiscal_year),
      fill = msft_colors$primary,
      alpha = 0.7,
      width = 0.7
    ) +
    
    # Operating margin line
    geom_line(
      aes(y = operating_margin * 600),  # Scale to fit on same chart (hack for visual)
      color = msft_colors$success,
      linewidth = 1.2
    ) +
    geom_point(
      aes(y = operating_margin * 600),
      color = msft_colors$success,
      size = 3
    ) +
    
    # Dual axis labels (manual)
    scale_y_continuous(
      name = "Revenue (Billions USD)",
      labels = scales::label_dollar(prefix = "$", suffix = "B"),
      sec.axis = sec_axis(
        ~ . / 600,
        name = "Operating Margin",
        labels = scales::label_percent()
      )
    ) +
    
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    
    labs(
      title = NULL,
      x = NULL
    ) +
    
    theme_msft() +
    theme(
      axis.title.y.right = element_text(color = msft_colors$success),
      axis.text.y.right = element_text(color = msft_colors$success)
    )
  
  # Return interactive plot
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 5,
    options = list(
      opts_tooltip(
        css = "background-color:#2C2C2C; color:white; padding:10px; border-radius:5px; font-size:14px;"
      ),
      opts_hover(css = "fill-opacity:1.0;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

# --- Growth & Mix Charts (templates for later) --------------------------------

chart_revenue_growth <- function(data) {
  # TODO: Build after Executive Brief validated
}

chart_segment_mix <- function(segment_data) {
  # TODO: Build after Executive Brief validated
}

# --- Profitability Charts (templates) -----------------------------------------

chart_margin_trends <- function(data) {
  # TODO
}

chart_rnd_intensity <- function(data) {
  # TODO
}

# --- Cash Engine Charts (templates) -------------------------------------------

chart_cash_flow_trends <- function(data) {
  # TODO
}

chart_fcf_margin <- function(data) {
  # TODO
}

# --- Balance Sheet Charts (templates) -----------------------------------------

chart_revenue_per_asset <- function(data) {
  # TODO
}

chart_balance_sheet_composition <- function(data) {
  # TODO
}