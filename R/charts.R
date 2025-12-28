# Clean Chart Functions - Microsoft Design Language
# All time-series charts use LINE + POINTS for consistency
# No duplicates, clean code

# ==============================================================================
# Executive Brief Charts
# ==============================================================================

#' Revenue Bars Chart - Clean Microsoft Style
#' @param data Financial data (annual)
#' @return ggiraph object
chart_revenue_bars_clean <- function(data) {
  
  plot_data <- data |>
    mutate(
      revenue_b = revenue / 1e9,
      label_text = paste0("$", round(revenue_b, 1), "B"),
      tooltip = paste0("FY", fiscal_year, "\nRevenue: $", round(revenue_b, 1), "B")
    )
  
  p <- ggplot(plot_data, aes(x = fiscal_year, y = revenue_b)) +
    geom_col_interactive(
      aes(tooltip = tooltip, data_id = fiscal_year),
      fill = "#0078D4",
      width = 0.75
    ) +
    geom_text(
      aes(label = label_text),
      vjust = -0.5,
      size = 3.5,
      color = "#323130",
      fontface = "bold"
    ) +
    scale_y_continuous(
      labels = function(x) paste0("$", x, "B"),
      expand = expansion(mult = c(0, 0.15))
    ) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = NULL) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      axis.text.y = element_text(color = "#605E5C", size = 9),
      text = element_text(color = "#323130")
    )
  
  girafe(
    ggobj = p,
    width_svg = 7,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); border: 1px solid #E1DFDD; font-family: 'Segoe UI', sans-serif;"),
      opts_hover(css = "fill-opacity:0.8;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

#' Operating Margin Line Chart - LINE + POINTS
#' @param data Financial data (annual)
#' @return ggiraph object
chart_operating_margin_line <- function(data) {
  
  plot_data <- data |>
    mutate(
      margin_pct = operating_margin * 100,
      label_text = paste0(round(margin_pct, 1), "%")
    )
  
  p <- ggplot(plot_data, aes(x = fiscal_year, y = margin_pct, group = 1)) +
    geom_line_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nOperating Margin: ", round(margin_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      linewidth = 1.5
    ) +
    geom_point_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nOperating Margin: ", round(margin_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      size = 4
    ) +
    geom_text(
      aes(label = label_text),
      vjust = -1,
      size = 3.5,
      color = "#323130",
      fontface = "bold"
    ) +
    scale_y_continuous(
      labels = function(x) paste0(x, "%"),
      expand = expansion(mult = c(0.05, 0.15))
    ) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = NULL) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      axis.text.y = element_text(color = "#605E5C", size = 9),
      text = element_text(color = "#323130")
    )
  
  girafe(
    ggobj = p,
    width_svg = 7,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px; box-shadow: 0 2px 8px rgba(0,0,0,0.15); border: 1px solid #E1DFDD; font-family: 'Segoe UI', sans-serif;"),
      opts_hover(css = "stroke-width:3;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

# ==============================================================================
# Growth & Mix Charts
# ==============================================================================

#' Revenue Growth Rate Chart - LINE + POINTS
#' @param data Financial data (annual)
#' @return ggiraph object
chart_revenue_growth_clean <- function(data) {
  
  plot_data <- data |>
    filter(!is.na(revenue_growth)) |>
    mutate(
      growth_pct = revenue_growth * 100,
      label_text = paste0(round(growth_pct, 1), "%")
    )
  
  p <- ggplot(plot_data, aes(x = fiscal_year, y = growth_pct, group = 1)) +
    geom_line_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nGrowth: ", round(growth_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      linewidth = 1.3
    ) +
    geom_point_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nGrowth: ", round(growth_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      size = 3.5
    ) +
    geom_text(
      aes(label = label_text),
      vjust = -1,
      size = 3.5,
      color = "#323130",
      fontface = "bold"
    ) +
    scale_y_continuous(
      labels = function(x) paste0(x, "%"),
      expand = expansion(mult = c(0.1, 0.15))
    ) +
    scale_x_continuous(
      breaks = seq(2017, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = NULL) +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px; font-family: 'Segoe UI', sans-serif;"),
      opts_hover(css = "stroke-width:2;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

#' Segment Mix (Stacked Area) - FIXED with group aesthetic
#' @param segment_data Segment revenue data
#' @return ggiraph object
chart_segment_mix <- function(segment_data) {
  
  if (is.null(segment_data) || nrow(segment_data) == 0) {
    message("Warning: segment_data is NULL or empty")
    return(NULL)
  }
  
  message("Segment data rows: ", nrow(segment_data))
  
  plot_data <- segment_data |>
    mutate(revenue_b = revenue / 1e9)
  
  actual_segments <- unique(plot_data$segment)
  message("Actual segments found: ", paste(actual_segments, collapse = " | "))
  
  colors_palette <- c("#0078D4", "#50E6FF", "#8764B8")
  segment_colors <- setNames(colors_palette[1:length(actual_segments)], actual_segments)
  
  # CRITICAL: group = segment for proper area rendering
  p <- ggplot(plot_data, aes(x = fiscal_year, y = revenue_b, fill = segment, group = segment)) +
    geom_area_interactive(
      aes(
        tooltip = paste0(segment, "\nFY", fiscal_year, "\n$", round(revenue_b, 1), "B"),
        data_id = segment
      ),
      alpha = 0.85,
      position = "stack"
    ) +
    scale_fill_manual(values = segment_colors) +
    scale_x_continuous(
      breaks = seq(min(plot_data$fiscal_year), max(plot_data$fiscal_year), 1),
      labels = function(x) paste0("FY", x)
    ) +
    scale_y_continuous(
      labels = function(x) paste0("$", x, "B"),
      expand = expansion(mult = c(0, 0.1))
    ) +
    labs(x = NULL, y = NULL, fill = "Segment") +
    theme_minimal(base_size = 12) +
    theme(
      legend.position = "top",
      legend.text = element_text(size = 10),
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      plot.background = element_rect(fill = "white", color = NA),
      panel.background = element_rect(fill = "white", color = NA),
      axis.text = element_text(color = "#323130")
    )
  
  message("Chart created successfully")
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 5,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "fill-opacity:0.9;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

#' Segment Comparison - Horizontal Bars
#' @param segment_data Segment revenue data
#' @return ggiraph object
chart_segment_comparison_horizontal <- function(segment_data) {
  
  plot_data <- segment_data |>
    filter(fiscal_year %in% c(2016, 2023)) |>
    mutate(
      fy_label = paste0("FY", fiscal_year),
      pct_label = round(pct_of_total * 100, 1)
    )
  
  p <- ggplot(plot_data, aes(x = pct_of_total, y = reorder(segment, pct_of_total), fill = fy_label)) +
    geom_col_interactive(
      aes(tooltip = paste0(segment, "\n", fy_label, ": ", pct_label, "%"),
          data_id = paste(segment, fy_label)),
      position = "dodge",
      alpha = 0.85
    ) +
    geom_text(
      aes(label = paste0(pct_label, "%"), group = fy_label),
      position = position_dodge(width = 0.9),
      hjust = -0.2,
      size = 3.5,
      color = "#323130"
    ) +
    scale_fill_manual(values = c("FY2016" = "#8A8886", "FY2023" = "#0078D4")) +
    scale_x_continuous(
      labels = scales::label_percent(scale = 100),
      expand = expansion(mult = c(0, 0.15))
    ) +
    labs(x = NULL, y = NULL, fill = NULL) +
    theme_minimal(base_size = 12) +
    theme(
      legend.position = "top",
      panel.grid.major.y = element_blank(),
      panel.grid.major.x = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "fill-opacity:0.9;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

# ==============================================================================
# Profitability Charts
# ==============================================================================

#' Margin Trends (3 lines) - LINE + POINTS with group aesthetic
#' @param data Financial data (annual)
#' @return ggiraph object
chart_margin_trends <- function(data) {
  
  plot_data <- data |>
    select(fiscal_year, gross_margin, operating_margin, net_margin) |>
    tidyr::pivot_longer(
      cols = c(gross_margin, operating_margin, net_margin),
      names_to = "metric",
      values_to = "value"
    ) |>
    mutate(
      value_pct = value * 100,
      metric_label = case_when(
        metric == "gross_margin" ~ "Gross Margin",
        metric == "operating_margin" ~ "Operating Margin",
        metric == "net_margin" ~ "Net Margin"
      )
    )
  
  colors <- c(
    "Gross Margin" = "#0078D4",
    "Operating Margin" = "#50E6FF",
    "Net Margin" = "#8764B8"
  )
  
  # CRITICAL: group = metric_label for proper line rendering
  p <- ggplot(plot_data, aes(x = fiscal_year, y = value_pct, color = metric_label, group = metric_label)) +
    geom_line_interactive(
      aes(tooltip = paste0(metric_label, "\nFY", fiscal_year, "\n", round(value_pct, 1), "%"),
          data_id = metric_label),
      linewidth = 1.3
    ) +
    geom_point_interactive(
      aes(tooltip = paste0(metric_label, "\nFY", fiscal_year, "\n", round(value_pct, 1), "%"),
          data_id = metric_label),
      size = 3
    ) +
    scale_color_manual(values = colors) +
    scale_y_continuous(
      labels = function(x) paste0(x, "%"),
      expand = expansion(mult = c(0.05, 0.1))
    ) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = NULL, color = NULL) +
    theme_minimal(base_size = 12) +
    theme(
      legend.position = "top",
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "stroke-width:2;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

#' R&D Intensity - LINE + POINTS
#' @param data Financial data (annual)
#' @return ggiraph object
chart_rnd_intensity <- function(data) {
  
  plot_data <- data |>
    filter(!is.na(rnd_intensity)) |>
    mutate(rnd_pct = rnd_intensity * 100)
  
  p <- ggplot(plot_data, aes(x = fiscal_year, y = rnd_pct, group = 1)) +
    geom_line_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nR&D Intensity: ", round(rnd_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      linewidth = 1.3
    ) +
    geom_point_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nR&D Intensity: ", round(rnd_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      size = 3.5
    ) +
    scale_y_continuous(
      labels = function(x) paste0(x, "%"),
      expand = expansion(mult = c(0.05, 0.1))
    ) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = "R&D / Revenue (%)") +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "stroke-width:2;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

# ==============================================================================
# Cash Engine Charts
# ==============================================================================

#' Cash Flow Trends - LINE + POINTS with group aesthetic
#' @param data Financial data (annual)
#' @return ggiraph object
chart_cash_flow_trends <- function(data) {
  
  plot_data <- data |>
    select(fiscal_year, cfo, fcf_proxy) |>
    tidyr::pivot_longer(
      cols = c(cfo, fcf_proxy),
      names_to = "metric",
      values_to = "value"
    ) |>
    mutate(
      value_b = value / 1e9,
      metric_label = case_when(
        metric == "cfo" ~ "Operating Cash Flow",
        metric == "fcf_proxy" ~ "Free Cash Flow"
      )
    )
  
  # CRITICAL: group = metric_label for proper line rendering
  p <- ggplot(plot_data, aes(x = fiscal_year, y = value_b, color = metric_label, group = metric_label)) +
    geom_line_interactive(
      aes(tooltip = paste0(metric_label, "\nFY", fiscal_year, "\n$", round(value_b, 1), "B"),
          data_id = metric_label),
      linewidth = 1.3
    ) +
    geom_point_interactive(
      aes(tooltip = paste0(metric_label, "\nFY", fiscal_year, "\n$", round(value_b, 1), "B"),
          data_id = metric_label),
      size = 3
    ) +
    scale_color_manual(
      values = c(
        "Operating Cash Flow" = "#0078D4",
        "Free Cash Flow" = "#50E6FF"
      )
    ) +
    scale_y_continuous(labels = function(x) paste0("$", x, "B")) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = "Cash Flow (Billions)", color = NULL) +
    theme_minimal(base_size = 12) +
    theme(
      legend.position = "top",
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 5,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "stroke-width:2;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

#' FCF Margin Trend - LINE + POINTS
#' @param data Financial data (annual)
#' @return ggiraph object
chart_fcf_margin <- function(data) {
  
  plot_data <- data |>
    filter(!is.na(fcf_margin)) |>
    mutate(fcf_margin_pct = fcf_margin * 100)
  
  p <- ggplot(plot_data, aes(x = fiscal_year, y = fcf_margin_pct, group = 1)) +
    geom_line_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nFCF Margin: ", round(fcf_margin_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      linewidth = 1.3
    ) +
    geom_point_interactive(
      aes(tooltip = paste0("FY", fiscal_year, "\nFCF Margin: ", round(fcf_margin_pct, 1), "%"),
          data_id = fiscal_year),
      color = "#0078D4",
      size = 3.5
    ) +
    geom_hline(yintercept = 30, linetype = "dashed", color = "#8A8886", alpha = 0.5) +
    annotate("text", x = 2020, y = 32, label = "30% threshold", color = "#8A8886", size = 3.5) +
    scale_y_continuous(labels = function(x) paste0(x, "%")) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = "FCF Margin (%)") +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "stroke-width:2;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

# ==============================================================================
# Balance Sheet Charts
# ==============================================================================

#' Revenue per Asset - LINE + POINTS
#' @param data Financial data (annual)
#' @return ggiraph object
chart_revenue_per_asset <- function(data) {
  
  plot_data <- data |>
    mutate(
      tooltip = paste0(
        "FY", fiscal_year, "\n",
        "Revenue/Asset: $", round(revenue_per_asset, 2)
      )
    )
  
  p <- ggplot(plot_data, aes(x = fiscal_year, y = revenue_per_asset, group = 1)) +
    geom_line_interactive(
      aes(tooltip = tooltip, data_id = fiscal_year),
      color = "#0078D4",
      linewidth = 1.3
    ) +
    geom_point_interactive(
      aes(tooltip = tooltip, data_id = fiscal_year),
      color = "#0078D4",
      size = 3.5
    ) +
    scale_y_continuous(labels = function(x) paste0("$", round(x, 2))) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = "Revenue per Dollar of Assets") +
    theme_minimal(base_size = 12) +
    theme(
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "stroke-width:2;"),
      opts_sizing(rescale = TRUE)
    )
  )
}

#' Balance Sheet Composition - LINE + POINTS with group aesthetic
#' @param data Financial data (annual)
#' @return ggiraph object
chart_balance_sheet_composition <- function(data) {
  
  plot_data <- data |>
    select(fiscal_year, cash_to_assets, debt_to_equity) |>
    tidyr::pivot_longer(
      cols = c(cash_to_assets, debt_to_equity),
      names_to = "metric",
      values_to = "value"
    ) |>
    mutate(
      metric_label = case_when(
        metric == "cash_to_assets" ~ "Cash / Assets",
        metric == "debt_to_equity" ~ "Debt / Equity"
      )
    )
  
  # CRITICAL: group = metric_label for proper line rendering
  p <- ggplot(plot_data, aes(x = fiscal_year, y = value, color = metric_label, group = metric_label)) +
    geom_line_interactive(
      aes(tooltip = paste0(metric_label, "\nFY", fiscal_year, "\n", round(value, 2)),
          data_id = metric_label),
      linewidth = 1.3
    ) +
    geom_point_interactive(
      aes(tooltip = paste0(metric_label, "\nFY", fiscal_year, "\n", round(value, 2)),
          data_id = metric_label),
      size = 3
    ) +
    scale_color_manual(
      values = c(
        "Cash / Assets" = "#0078D4",
        "Debt / Equity" = "#50E6FF"
      )
    ) +
    scale_x_continuous(
      breaks = seq(2016, 2023, 1),
      labels = function(x) paste0("FY", x)
    ) +
    labs(x = NULL, y = "Ratio", color = NULL) +
    theme_minimal(base_size = 12) +
    theme(
      legend.position = "top",
      panel.grid.major.x = element_blank(),
      panel.grid.major.y = element_line(color = "#F3F2F1", linewidth = 0.3),
      text = element_text(color = "#323130"),
      axis.text = element_text(color = "#605E5C")
    )
  
  girafe(
    ggobj = p,
    width_svg = 10,
    height_svg = 4,
    options = list(
      opts_tooltip(css = "background-color:#FFFFFF; color:#323130; padding:10px; border-radius:4px;"),
      opts_hover(css = "stroke-width:2;"),
      opts_sizing(rescale = TRUE)
    )
  )
}