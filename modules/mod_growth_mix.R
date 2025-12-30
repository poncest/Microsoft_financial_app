# Module: Growth & Mix
# Tests H1: Revenue growth accelerated (cloud transition effect)

# ==============================================================================
# UI
# ==============================================================================

mod_growth_mix_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Growth & Mix", style = "color: #004578; margin-bottom: 0.3em;"),
    p("Revenue growth trajectory and segment composition changes",
      style = "color: #605E5C; margin-bottom: 2em;"),
    
    # Revenue Growth Rate Chart
    div(
      class = "ui segment",
      style = "margin-top: 1.5em; padding: 2em; background: white;",
      h4("Revenue Growth Rate (YoY)", style = "color: #004578; margin-bottom: 0.5em;"),
      p("Annual growth rates showing acceleration pattern", style = "color: #605E5C; font-size: 0.9em;"),
      girafeOutput(ns("chart_revenue_growth"), height = "320px")
    ),
    
    # Segment Mix Chart
    div(
      class = "ui segment",
      style = "margin-top: 1.5em; padding: 2em; background: white;",
      h4("Revenue by Segment", style = "color: #004578; margin-bottom: 0.5em;"),
      p("Three business segments over time", style = "color: #605E5C; font-size: 0.9em;"),
      girafeOutput(ns("chart_segment_mix"), height = "350px")
    ),
    
    # Segment Comparison
    div(
      class = "ui segment",
      style = "margin-top: 1.5em; padding: 2em; background: white;",
      h4("Segment Mix Shift (FY2016 vs FY2023)", style = "color: #004578; margin-bottom: 0.5em;"),
      p("Percentage of total revenue by segment", style = "color: #605E5C; font-size: 0.9em;"),
      girafeOutput(ns("chart_segment_comparison"), height = "280px")
    ),
    
    # Key Findings Box
    div(
      class = "ui message",
      style = "margin-top: 2em; border-left: 4px solid #0078D4; background: #F3F2F1;",
      div(class = "header", style = "color: #004578;", "Key Findings"),
      uiOutput(ns("growth_insight"))
    ),
    
    # H1 Hypothesis Callout
    div(
      style = "margin-top: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
      div(
        style = "display: flex; justify-content: space-between; align-items: center;",
        div(
          style = "flex: 1;",
          h4("Hypothesis H1: Revenue acceleration coincides with increased cloud mix",
             style = "color: #004578; margin-bottom: 0.5em;"),
          div(style = "color: #605E5C; font-size: 0.9em; margin-bottom: 0.3em;", "Growth & Mix tab")
        ),
        div(
          style = "padding: 0.5em 1em; background: #107C10; color: white; border-radius: 4px; font-weight: 600; font-size: 0.85em;",
          "Directionally supported"
        )
      ),
      p(
        style = "color: #323130; line-height: 1.6; margin-top: 0.8em;",
        uiOutput(ns("hypothesis_h1"), inline = TRUE)
      )
    )
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_growth_mix_server <- function(id, financials, segments, app_metrics) {
  moduleServer(id, function(input, output, session) {
    
    # --- Chart Outputs ---
    
    output$chart_revenue_growth <- renderGirafe({
      chart_revenue_growth_clean(financials)
    })
    
    output$chart_segment_mix <- renderGirafe({
      chart_segment_mix(segments)
    })
    
    output$chart_segment_comparison <- renderGirafe({
      chart_segment_comparison_horizontal(segments)
    })
    
    # --- Key Findings ---
    
    output$growth_insight <- renderUI({
      cagr_early_pct <- app_metrics$cagr_early * 100
      cagr_late_pct <- app_metrics$cagr_late * 100
      
      cloud_2016 <- segments |> filter(fiscal_year == 2016, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_2023 <- segments |> filter(fiscal_year == 2023, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_change <- (cloud_2023 - cloud_2016) * 100
      
      pc_2016 <- segments |> filter(fiscal_year == 2016, segment == "More Personal Computing") |> pull(pct_of_total)
      pc_2023 <- segments |> filter(fiscal_year == 2023, segment == "More Personal Computing") |> pull(pct_of_total)
      pc_change <- (pc_2023 - pc_2016) * 100
      
      HTML(sprintf(
        "<ul style='line-height: 1.8; color: #323130;'>
          <li>Revenue growth accelerated from <strong>%.1f%% CAGR</strong> (FY2016-2019) to <strong>%.1f%% CAGR</strong> (FY2020-2023)</li>
          <li>Intelligent Cloud grew from <strong>%.1f%%</strong> to <strong>%.1f%%</strong> of total revenue (<strong>%+.1fpp</strong>)</li>
          <li>More Personal Computing declined from <strong>%.1f%%</strong> to <strong>%.1f%%</strong> of revenue (<strong>%+.1fpp</strong>)</li>
        </ul>",
        cagr_early_pct,
        cagr_late_pct,
        cloud_2016 * 100,
        cloud_2023 * 100,
        cloud_change,
        pc_2016 * 100,
        pc_2023 * 100,
        pc_change
      ))
    })
    
    # --- Hypothesis Evidence ---
    
    output$hypothesis_h1 <- renderUI({
      cagr_early_pct <- app_metrics$cagr_early * 100
      cagr_late_pct <- app_metrics$cagr_late * 100
      cagr_acceleration <- cagr_late_pct - cagr_early_pct
      
      cloud_2016 <- segments |> filter(fiscal_year == 2016, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_2023 <- segments |> filter(fiscal_year == 2023, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_change <- (cloud_2023 - cloud_2016) * 100
      
      HTML(sprintf(
        "Revenue CAGR accelerated by <strong>%.1fpp</strong> (%.1f%% → %.1f%%) as Intelligent Cloud expanded <strong>%.1fpp</strong> to 41.7%% of revenue.",
        cagr_acceleration, cagr_early_pct, cagr_late_pct, cloud_change
      ))
    })
    
  })
}