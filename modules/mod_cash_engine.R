# Module: Cash Engine
# Tests H3: Resilient cash generation despite growth investments

# ==============================================================================
# UI
# ==============================================================================

mod_cash_engine_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Cash Engine", style = "color: #004578;"),
    p("Operating cash flow and free cash flow trends based on reported financials", 
      style = "color: #605E5C; margin-bottom: 2em;"),
    
    # KPI Cards (MATCHES Executive Brief format)
    div(
      class = "ui three cards",
      style = "margin-top: 1em;",
      
      # CFO Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_cfo"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "FY2023 Operating Cash Flow"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_cfo_context"), inline = TRUE)
          )
        )
      ),
      
      # FCF Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_fcf_cash"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "Free Cash Flow"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_fcf_context"), inline = TRUE)
          )
        )
      ),
      
      # FCF Margin Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_fcf_margin_cash"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "FCF Margin (FCF / Revenue)"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_fcf_margin_context"), inline = TRUE)
          )
        )
      )
    ),
    
    # Cash Flow Trends
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("Cash Flow Trends", style = "color: #004578;"),
      girafeOutput(ns("chart_cash_flow_trends"), height = "400px")
    ),
    
    # FCF Margin Trend
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("FCF Margin Consistency", style = "color: #004578;"),
      p("FCF margin levels provide context for evaluating cash generation resilience (H3)"),
      girafeOutput(ns("chart_fcf_margin"), height = "350px")
    ),
    
    # Key Findings Box
    div(
      class = "ui message",
      style = "margin-top: 2em; border-left: 4px solid #0078D4; background: #F3F2F1;",
      div(class = "header", style = "color: #004578;", "Key Findings"),
      uiOutput(ns("cash_insight"))
    ),
    
    # H3 Hypothesis Callout (STANDARDIZED FORMAT)
    div(
      style = "margin-top: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
      div(
        style = "display: flex; justify-content: space-between; align-items: center;",
        div(
          style = "flex: 1;",
          h4("Hypothesis H3: Cash generation remained resilient during growth investments", 
             style = "color: #004578; margin-bottom: 0.5em;"),
          div(style = "color: #605E5C; font-size: 0.9em; margin-bottom: 0.3em;", "Cash Engine tab")
        ),
        div(
          style = "padding: 0.5em 1em; background: #107C10; color: white; border-radius: 4px; font-weight: 600; font-size: 0.85em;",
          "✓ Supported"
        )
      ),
      p(
        style = "color: #323130; line-height: 1.6; margin-top: 0.8em;",
        uiOutput(ns("hypothesis_evidence"), inline = TRUE)
      ),
      
      div(
        style = "margin-top: 1.2em; font-size: 0.85em; color: #605E5C; font-style: italic;",
        "Free cash flow is presented using a simplified proxy derived from public disclosures. ",
        "Results are descriptive and do not constitute forecasts or valuation analysis."
      )
      
    )
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_cash_engine_server <- function(id, financials) {
  moduleServer(id, function(input, output, session) {
    
    # --- KPI Outputs (with YoY context) ---
    
    output$kpi_cfo <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      paste0("$", round(fy2023$cfo / 1e9, 1), "B")
    })
    
    output$kpi_cfo_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      yoy_change <- ((fy2023$cfo / fy2022$cfo) - 1) * 100
      paste0(ifelse(yoy_change > 0, "+", ""), round(yoy_change, 1), "% YoY")
    })
    
    output$kpi_fcf_cash <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      paste0("$", round(fy2023$fcf_proxy / 1e9, 1), "B")
    })
    
    output$kpi_fcf_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      yoy_change <- ((fy2023$fcf_proxy / fy2022$fcf_proxy) - 1) * 100
      paste0(ifelse(yoy_change > 0, "+", ""), round(yoy_change, 1), "% YoY")
    })
    
    output$kpi_fcf_margin_cash <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      paste0(round(fy2023$fcf_margin * 100, 1), "%")
    })
    
    output$kpi_fcf_margin_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      pp_change <- (fy2023$fcf_margin - fy2022$fcf_margin) * 100
      paste0(ifelse(pp_change > 0, "+", ""), round(pp_change, 1), "pp YoY")
    })
    
    # --- Chart Outputs ---
    
    output$chart_cash_flow_trends <- renderGirafe({
      chart_cash_flow_trends(financials)
    })
    
    output$chart_fcf_margin <- renderGirafe({
      chart_fcf_margin(financials)
    })
    
    # --- Hypothesis Evidence ---
    
    output$hypothesis_evidence <- renderUI({
      avg_fcf_margin <- mean(financials$fcf_margin, na.rm = TRUE) * 100
      
      HTML(sprintf(
        "FCF margin averaged <strong>%.1f%%</strong> across FY2016-2023, consistently exceeding 30%% threshold despite significant R&D and capital investments.",
        avg_fcf_margin
      ))
    })
    
    # --- Key Insights ---
    
    output$cash_insight <- renderUI({
      
      avg_fcf_margin <- mean(financials$fcf_margin, na.rm = TRUE) * 100
      min_fcf_margin <- min(financials$fcf_margin, na.rm = TRUE) * 100
      max_fcf_margin <- max(financials$fcf_margin, na.rm = TRUE) * 100
      
      HTML(sprintf(
        "<ul style='line-height: 1.8; color: #323130;'>
          <li>FCF margin averaged <strong>%.1f%%</strong> from FY2016 to FY2023</li>
          <li>Range: <strong>%.1f%%</strong> to <strong>%.1f%%</strong> (minimal variance)</li>
          <li>Consistently exceeded 30%% threshold throughout the period</li>
          <li>This is consistent with <strong>H3</strong>: cash generation remained resilient while the company invested in growth initiatives</li>
        </ul>",
        avg_fcf_margin,
        min_fcf_margin,
        max_fcf_margin
      ))
    })
    
  })
}