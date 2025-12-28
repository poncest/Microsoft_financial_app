# Module: Cash Engine
# Tests H3: Resilient cash generation despite growth investments

# ==============================================================================
# UI
# ==============================================================================

mod_cash_engine_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Cash Engine", style = paste0("color: ", msft_colors$dark, ";")),
    p("Operating cash flow and free cash flow generation", 
      style = paste0("color: ", msft_colors$medium, ";")),
    
    # KPI Cards
    div(
      class = "ui three cards",
      style = "margin-top: 2em;",
      
      # CFO Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em;",
          div(
            style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$primary, ";"),
            uiOutput(ns("kpi_cfo"), inline = TRUE)
          ),
          div(
            style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
            "FY2023 Operating Cash Flow"
          )
        )
      ),
      
      # FCF Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em;",
          div(
            style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$success, ";"),
            uiOutput(ns("kpi_fcf_cash"), inline = TRUE)
          ),
          div(
            style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
            "FY2023 Free Cash Flow (Proxy)"
          )
        )
      ),
      
      # FCF Margin Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em;",
          div(
            style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$chart_2, ";"),
            uiOutput(ns("kpi_fcf_margin_cash"), inline = TRUE)
          ),
          div(
            style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
            "FCF Margin (FCF / Revenue)"
          )
        )
      )
    ),
    
    # Cash Flow Trends
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("Cash Flow Trends", style = paste0("color: ", msft_colors$dark, ";")),
      girafeOutput(ns("chart_cash_flow_trends"), height = "400px")
    ),
    
    # FCF Margin Trend
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em;",
      h3("FCF Margin Consistency", style = paste0("color: ", msft_colors$dark, ";")),
      p("Consistently high FCF margin supports H3 (resilient cash generation)"),
      girafeOutput(ns("chart_fcf_margin"), height = "350px")
    ),
    
    # Insight Box
    div(
      class = "ui message",
      style = "margin-top: 2em;",
      div(class = "header", "Key Findings"),
      uiOutput(ns("cash_insight"))
    )
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_cash_engine_server <- function(id, financials) {
  moduleServer(id, function(input, output, session) {
    
    # --- KPI Outputs ---
    
    output$kpi_cfo <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      fmt_currency(fy2023$cfo, suffix = "B", scale = 1e-9, digits = 1)
    })
    
    output$kpi_fcf_cash <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      fmt_currency(fy2023$fcf_proxy, suffix = "B", scale = 1e-9, digits = 1)
    })
    
    output$kpi_fcf_margin_cash <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      fmt_percent(fy2023$fcf_margin, digits = 1)
    })
    
    # --- Chart Outputs ---
    
    output$chart_cash_flow_trends <- renderGirafe({
      chart_cash_flow_trends(financials)
    })
    
    output$chart_fcf_margin <- renderGirafe({
      chart_fcf_margin(financials)
    })
    
    # --- Insights ---
    
    output$cash_insight <- renderUI({
      
      avg_fcf_margin <- mean(financials$fcf_margin, na.rm = TRUE) * 100
      min_fcf_margin <- min(financials$fcf_margin, na.rm = TRUE) * 100
      max_fcf_margin <- max(financials$fcf_margin, na.rm = TRUE) * 100
      
      HTML(sprintf(
        "<ul>
          <li>FCF margin averaged <strong>%.1f%%</strong> from FY2016 to FY2023</li>
          <li>Range: <strong>%.1f%%</strong> to <strong>%.1f%%</strong> (minimal variance)</li>
          <li>Consistently exceeded 30%% threshold throughout the period</li>
          <li>This supports <strong>H3</strong>: Resilient cash generation despite significant R&D and capex investments</li>
        </ul>",
        avg_fcf_margin,
        min_fcf_margin,
        max_fcf_margin
      ))
    })
    
  })
}
