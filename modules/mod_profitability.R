# Module: Profitability Drivers
# Tests H2: Margin expansion from mix shift, not cost compression

# ==============================================================================
# UI
# ==============================================================================

mod_profitability_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Profitability Drivers", style = "color: #004578; margin-bottom: 0.3em;"),
    p("Margin evolution and cost structure analysis", 
      style = "color: #605E5C; margin-bottom: 2em;"),
    
    # Margin Trends (Multi-Line)
    div(
      class = "ui segment",
      style = "margin-top: 1.5em; padding: 2em; background: white;",
      h4("Margin Trends (FY2016-2023)", style = "color: #004578; margin-bottom: 0.5em;"),
      p("All three margins expanding suggests mix shift, not just cost control", 
        style = "color: #605E5C; font-size: 0.9em;"),
      girafeOutput(ns("chart_margin_trends"), height = "320px")
    ),
    
    # R&D Intensity
    div(
      class = "ui segment",
      style = "margin-top: 1.5em; padding: 2em; background: white;",
      h4("R&D Intensity (R&D / Revenue)", style = "color: #004578; margin-bottom: 0.5em;"),
      p("Stable R&D spending despite margin expansion", 
        style = "color: #605E5C; font-size: 0.9em;"),
      girafeOutput(ns("chart_rnd_intensity"), height = "320px")
    ),
    
    # Key Findings Box
    div(
      class = "ui message",
      style = "margin-top: 2em; border-left: 4px solid #0078D4; background: #F3F2F1;",
      div(
        class = "header",
        style = "color: #004578;",
        "Key Findings"
      ),
      uiOutput(ns("profitability_insight"))
    ),
    
    # H2 Hypothesis Callout (STANDARDIZED FORMAT)
    div(
      style = "margin-top: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
      div(
        style = "display: flex; justify-content: space-between; align-items: center;",
        div(
          style = "flex: 1;",
          h4("Hypothesis H2: Margin expansion driven by mix shift, not cost compression", 
             style = "color: #004578; margin-bottom: 0.5em;"),
          div(style = "color: #605E5C; font-size: 0.9em; margin-bottom: 0.3em;", "Profitability Drivers tab")
        ),
        div(
          style = "padding: 0.5em 1em; background: #107C10; color: white; border-radius: 4px; font-weight: 600; font-size: 0.85em;",
          "✓ SUPPORTED"
        )
      ),
      p(
        style = "color: #323130; line-height: 1.6; margin-top: 0.8em;",
        uiOutput(ns("hypothesis_h2"), inline = TRUE)
      )
    )
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_profitability_server <- function(id, financials) {
  moduleServer(id, function(input, output, session) {
    
    # --- Chart Outputs ---
    
    output$chart_margin_trends <- renderGirafe({
      chart_margin_trends(financials)
    })
    
    output$chart_rnd_intensity <- renderGirafe({
      chart_rnd_intensity(financials)
    })
    
    # --- Key Findings (bullets only) ---
    
    output$profitability_insight <- renderUI({
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      gross_expansion <- (fy2023$gross_margin - fy2016$gross_margin) * 100
      op_expansion <- (fy2023$operating_margin - fy2016$operating_margin) * 100
      avg_rnd <- mean(financials$rnd_intensity, na.rm = TRUE) * 100
      
      HTML(sprintf(
        "<ul style='line-height: 1.8; color: #323130;'>
          <li>Gross margin expanded <strong>%.1fpp</strong> (%.1f%% → %.1f%%)</li>
          <li>Operating margin expanded <strong>%.1fpp</strong> (%.1f%% → %.1f%%)</li>
          <li>R&D intensity remained stable at ~<strong>%.1f%%</strong> throughout the period</li>
        </ul>",
        gross_expansion,
        fy2016$gross_margin * 100,
        fy2023$gross_margin * 100,
        op_expansion,
        fy2016$operating_margin * 100,
        fy2023$operating_margin * 100,
        avg_rnd
      ))
    })
    
    # --- Hypothesis Evidence ---
    
    output$hypothesis_h2 <- renderUI({
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      op_expansion <- (fy2023$operating_margin - fy2016$operating_margin) * 100
      avg_rnd <- mean(financials$rnd_intensity, na.rm = TRUE) * 100
      
      HTML(sprintf(
        "Operating margin expanded <strong>%.1fpp</strong> (%.1f%% → %.1f%%) while R&D intensity remained stable at ~<strong>%.1f%%</strong>, indicating profitability gains came from revenue mix (cloud services) rather than cost reduction.",
        op_expansion,
        fy2016$operating_margin * 100,
        fy2023$operating_margin * 100,
        avg_rnd
      ))
    })
    
  })
}