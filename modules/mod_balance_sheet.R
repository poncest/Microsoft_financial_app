# Module: Balance Sheet & Capital
# Tests H4 (capital efficiency) + H5 (balance sheet strength)

# ==============================================================================
# UI
# ==============================================================================

mod_balance_sheet_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Balance Sheet & Capital", style = paste0("color: ", msft_colors$dark, ";")),
    p("Asset efficiency and balance sheet composition", 
      style = paste0("color: ", msft_colors$medium, ";")),
    
    # KPI Cards
    div(
      class = "ui three cards",
      style = "margin-top: 2em;",
      
      # Total Assets Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em;",
          div(
            style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$primary, ";"),
            uiOutput(ns("kpi_total_assets"), inline = TRUE)
          ),
          div(
            style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
            "FY2023 Total Assets"
          )
        )
      ),
      
      # Cash Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em;",
          div(
            style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$success, ";"),
            uiOutput(ns("kpi_cash_bs"), inline = TRUE)
          ),
          div(
            style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
            "FY2023 Cash & Equivalents"
          )
        )
      ),
      
      # Debt-to-Equity Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em;",
          div(
            style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$chart_2, ";"),
            uiOutput(ns("kpi_debt_to_equity_bs"), inline = TRUE)
          ),
          div(
            style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
            "Debt-to-Equity Ratio"
          )
        )
      )
    ),
    
    # Revenue per Asset (H4)
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("Revenue per Dollar of Assets", style = paste0("color: ", msft_colors$dark, ";")),
      p("Tests H4: Improving capital efficiency (asset-light model)"),
      girafeOutput(ns("chart_revenue_per_asset"), height = "350px")
    ),
    
    # Balance Sheet Composition
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("Balance Sheet Strength Indicators", style = paste0("color: ", msft_colors$dark, ";")),
      girafeOutput(ns("chart_balance_sheet_composition"), height = "350px")
    ),
    
    # Insight Box
    div(
      class = "ui message",
      style = "margin-top: 2em;",
      div(class = "header", "Key Findings"),
      uiOutput(ns("balance_sheet_insight"))
    )
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_balance_sheet_server <- function(id, financials) {
  moduleServer(id, function(input, output, session) {
    
    # --- KPI Outputs ---
    
    output$kpi_total_assets <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      fmt_currency(fy2023$total_assets, suffix = "B", scale = 1e-9, digits = 0)
    })
    
    output$kpi_cash_bs <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      fmt_currency(fy2023$cash, suffix = "B", scale = 1e-9, digits = 0)
    })
    
    output$kpi_debt_to_equity_bs <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      fmt_number(fy2023$debt_to_equity, digits = 2)
    })
    
    # --- Chart Outputs ---
    
    output$chart_revenue_per_asset <- renderGirafe({
      chart_revenue_per_asset(financials)
    })
    
    output$chart_balance_sheet_composition <- renderGirafe({
      chart_balance_sheet_composition(financials)
    })
    
    # --- Insights ---
    
    output$balance_sheet_insight <- renderUI({
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      rpa_2016 <- fy2016$revenue_per_asset
      rpa_2023 <- fy2023$revenue_per_asset
      rpa_change <- ((rpa_2023 / rpa_2016) - 1) * 100
      
      cash_to_assets_2023 <- fy2023$cash_to_assets * 100
      
      HTML(sprintf(
        "<ul>
          <li>Revenue per dollar of assets increased <strong>%.1f%%</strong> from FY2016 to FY2023</li>
          <li>Improved from <strong>$%.2f</strong> to <strong>$%.2f</strong> (supports H4: capital efficiency)</li>
          <li>Cash represents <strong>%.1f%%</strong> of total assets in FY2023</li>
          <li>Strong balance sheet provides flexibility for capital returns and strategic investments (supports H5)</li>
        </ul>",
        rpa_change,
        rpa_2016,
        rpa_2023,
        cash_to_assets_2023
      ))
    })
    
  })
}
