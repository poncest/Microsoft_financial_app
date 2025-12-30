# Module: Balance Sheet & Capital
# Tests H4 (capital efficiency) + H5 (balance sheet strength)

# ==============================================================================
# UI
# ==============================================================================

mod_balance_sheet_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Balance Sheet & Capital", style = "color: #004578;"),
    p("Asset efficiency and balance sheet composition based on reported financials", 
      style = "color: #605E5C; margin-bottom: 2em;"),
    
    # KPI Cards (MATCHES Executive Brief format)
    div(
      class = "ui three cards",
      style = "margin-top: 1em;",
      
      # Total Assets Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_total_assets"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "FY2023 Total Assets"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_assets_context"), inline = TRUE)
          )
        )
      ),
      
      # Cash Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_cash_bs"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "Cash & Equivalents"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_cash_context"), inline = TRUE)
          )
        )
      ),
      
      # Debt-to-Equity Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_debt_to_equity_bs"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "Debt-to-Equity Ratio"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            "Moderate Leverage"
          )
        )
      )
    ),
    
    # Revenue per Asset (H4)
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("Revenue per Dollar of Assets", style = "color: #004578;"),
      p("Evaluates H4: Changes in capital efficiency over time", 
        style = "color: #605E5C; font-size: 0.9em;"),
      girafeOutput(ns("chart_revenue_per_asset"), height = "350px")
    ),
    
    # Balance Sheet Composition
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("Balance Sheet Strength Indicators", style = "color: #004578;"),
      girafeOutput(ns("chart_balance_sheet_composition"), height = "350px")
    ),
    
    # Key Findings Box
    div(
      class = "ui message",
      style = "margin-top: 2em; border-left: 4px solid #0078D4; background: #F3F2F1;",
      div(class = "header", style = "color: #004578;", "Key Findings"),
      uiOutput(ns("balance_sheet_insight"))
    ),
    
    # H4 Hypothesis Callout (STANDARDIZED FORMAT)
    div(
      style = "margin-top: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
      div(
        style = "display: flex; justify-content: space-between; align-items: center;",
        div(
          style = "flex: 1;",
          h4("Hypothesis H4: Capital efficiency improved over the period", 
             style = "color: #004578; margin-bottom: 0.5em;"),
          div(style = "color: #605E5C; font-size: 0.9em; margin-bottom: 0.3em;", "Balance Sheet tab")
        ),
        div(
          style = "padding: 0.5em 1em; background: #107C10; color: white; border-radius: 4px; font-weight: 600; font-size: 0.85em;",
          "✓ Supported"
        )
      ),
      p(
        style = "color: #323130; line-height: 1.6; margin-top: 0.8em;",
        uiOutput(ns("hypothesis_h4"), inline = TRUE)
      )
    ),
    
    # H5 Hypothesis Callout (STANDARDIZED FORMAT)
    div(
      style = "margin-top: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
      div(
        style = "display: flex; justify-content: space-between; align-items: center;",
        div(
          style = "flex: 1;",
          h4("Hypothesis H5: Balance sheet strength provides capital flexibility", 
             style = "color: #004578; margin-bottom: 0.5em;"),
          div(style = "color: #605E5C; font-size: 0.9em; margin-bottom: 0.3em;", "Balance Sheet tab")
        ),
        div(
          style = "padding: 0.5em 1em; background: #107C10; color: white; border-radius: 4px; font-weight: 600; font-size: 0.85em;",
          "Supported (descriptive)"
        )
      ),
      p(
        style = "color: #323130; line-height: 1.6; margin-top: 0.8em;",
        uiOutput(ns("hypothesis_h5"), inline = TRUE)
      )
    ),
    
    div(
      style = "margin-top: 1.2em; font-size: 0.85em; color: #605E5C; font-style: italic;",
      "Balance sheet analysis is based on consolidated historical disclosures. ",
      "Results are descriptive and do not assess management intent, capital allocation priorities, or future leverage decisions."
    )
    
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_balance_sheet_server <- function(id, financials) {
  moduleServer(id, function(input, output, session) {
    
    # --- KPI Outputs (with YoY context) ---
    
    output$kpi_total_assets <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      paste0("$", round(fy2023$total_assets / 1e9, 0), "B")
    })
    
    output$kpi_assets_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      yoy_change <- ((fy2023$total_assets / fy2022$total_assets) - 1) * 100
      paste0(ifelse(yoy_change > 0, "+", ""), round(yoy_change, 1), "% YoY")
    })
    
    output$kpi_cash_bs <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      paste0("$", round(fy2023$cash / 1e9, 0), "B")
    })
    
    output$kpi_cash_context <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      cash_pct <- fy2023$cash_to_assets * 100
      paste0(round(cash_pct, 1), "% of Assets")
    })
    
    output$kpi_debt_to_equity_bs <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      round(fy2023$debt_to_equity, 2)
    })
    
    # --- Chart Outputs ---
    
    output$chart_revenue_per_asset <- renderGirafe({
      chart_revenue_per_asset(financials)
    })
    
    output$chart_balance_sheet_composition <- renderGirafe({
      chart_balance_sheet_composition(financials)
    })
    
    # --- Key Findings (bullets only) ---
    
    output$balance_sheet_insight <- renderUI({
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      rpa_change <- ((fy2023$revenue_per_asset / fy2016$revenue_per_asset) - 1) * 100
      cash_to_assets_2023 <- fy2023$cash_to_assets * 100
      
      HTML(sprintf(
        "<ul style='line-height: 1.8; color: #323130;'>
          <li>Revenue per dollar of assets increased <strong>%.1f%%</strong> from FY2016 to FY2023</li>
          <li>Improved from <strong>$%.2f</strong> to <strong>$%.2f</strong> (is consistent with improved capital efficiency (H4))</li>
          <li>Cash represents <strong>%.1f%%</strong> of total assets in FY2023</li>
          <li>Balance sheet strength indicates capacity for capital flexibility (H5), without assessing future allocation decisions</li>
        </ul>",
        rpa_change,
        fy2016$revenue_per_asset,
        fy2023$revenue_per_asset,
        cash_to_assets_2023
      ))
    })
    
    # --- Hypothesis H4 Evidence ---
    
    output$hypothesis_h4 <- renderUI({
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      rpa_change <- ((fy2023$revenue_per_asset / fy2016$revenue_per_asset) - 1) * 100
      
      HTML(sprintf(
        "Revenue per dollar of assets increased <strong>%.1f%%</strong> ($%.2f → $%.2f), indicating improved capital efficiency over the period. This does not isolate underlying drivers.",
        rpa_change,
        fy2016$revenue_per_asset,
        fy2023$revenue_per_asset
      ))
    })
    
    # --- Hypothesis H5 Evidence ---
    
    output$hypothesis_h5 <- renderUI({
      
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      cash_b <- fy2023$cash / 1e9
      debt_to_equity <- fy2023$debt_to_equity
      
      HTML(sprintf(
        "Strong cash position ($<strong>%.1fB</strong>) and moderate debt-to-equity ratio (<strong>%.2f</strong>) indicate financial flexibility at the end of the period, without implying future capital allocation outcomes.",
        cash_b,
        debt_to_equity
      ))
    })
    
  })
}