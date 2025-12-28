# ==============================================================================
# Server - Main Logic
# Author: Steven Ponce
# ==============================================================================

# Source chart functions (if not already loaded by global.R)
if (!exists("chart_executive_trend")) {
  source("server_charts.R")
}

server <- function(input, output, session) {
  
  # --- Executive Brief Tab ----------------------------------------------------
  
  # KPI Cards (FY2023 values)
  fy2023 <- financials |> filter(fiscal_year == 2023)
  
  output$kpi_revenue <- renderText({
    fmt_currency(fy2023$revenue, suffix = "B", scale = 1e-9, digits = 0)
  })
  
  output$kpi_gross_margin <- renderText({
    fmt_percent(fy2023$gross_margin, digits = 1)
  })
  
  output$kpi_operating_margin <- renderText({
    fmt_percent(fy2023$operating_margin, digits = 1)
  })
  
  output$kpi_fcf <- renderText({
    fmt_currency(fy2023$fcf_proxy, suffix = "B", scale = 1e-9, digits = 0)
  })
  
  output$kpi_growth <- renderText({
    # FY2023 YoY growth
    growth <- financials |> 
      filter(fiscal_year == 2023) |> 
      pull(revenue_growth)
    fmt_percent(growth, digits = 1)
  })
  
  # Executive trend chart
  output$chart_executive_trend <- renderGirafe({
    chart_executive_trend(financials)
  })
  
  # Key insight
  output$executive_insight <- renderUI({
    fy2016 <- financials |> filter(fiscal_year == 2016)
    fy2023 <- financials |> filter(fiscal_year == 2023)
    
    revenue_growth_total <- ((fy2023$revenue / fy2016$revenue) - 1) * 100
    margin_expansion <- (fy2023$operating_margin - fy2016$operating_margin) * 100
    
    HTML(sprintf(
      "Revenue grew <strong>%.0f%%</strong> from FY2016 to FY2023 while operating margin expanded <strong>%.1f percentage points</strong>, reflecting Microsoft's shift toward higher-margin cloud services.",
      revenue_growth_total,
      margin_expansion
    ))
  })
  
}