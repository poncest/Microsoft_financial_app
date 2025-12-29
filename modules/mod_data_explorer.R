# Module: Data Explorer
# Full dataset with export capability and methodology documentation

# ==============================================================================
# UI
# ==============================================================================

mod_data_explorer_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Data Explorer", style = "color: #004578;"),
    p("Full dataset with export capability and methodology documentation", 
      style = "color: #605E5C; margin-bottom: 2em;"),
    
    # Download Button
    div(
      style = "margin-top: 1em; margin-bottom: 1.5em;",
      downloadButton(
        ns("download_csv"),
        "Download Full Dataset (CSV)",
        class = "ui primary button",
        icon = icon("download")
      )
    ),
    
    # Reactable Table
    div(
      class = "ui segment",
      style = "padding: 2em; background: white;",
      h3("Financial Summary (FY2016-2023)", style = "color: #004578; margin-bottom: 1em;"),
      reactableOutput(ns("table_financials"))
    ),
    
    # Methodology Section
    div(
      class = "ui segment",
      style = "margin-top: 2em; padding: 2em; background: white;",
      h3("Data Sources & Methodology", style = "color: #004578; margin-bottom: 1em;"),
      
      tags$h4("Primary Data Source", style = "color: #323130; margin-top: 1.5em;"),
      tags$p("SEC EDGAR XBRL Company Facts API", style = "color: #605E5C;"),
      tags$ul(
        style = "color: #323130; line-height: 1.6;",
        tags$li("Company: Microsoft Corporation (CIK 0000789019)"),
        tags$li("Filings: Annual 10-K reports (FY2016–FY2023)"),
        tags$li("API Endpoint: ", tags$code("https://data.sec.gov/api/xbrl/companyfacts/CIK0000789019.json", 
                                            style = "background: #F3F2F1; padding: 2px 6px; border-radius: 3px;"))
      ),
      
      tags$h4("Key Metrics Derivation", style = "color: #323130; margin-top: 1.5em;"),
      tags$ul(
        style = "color: #323130; line-height: 1.6;",
        tags$li(tags$strong("Revenue:"), " Consolidated from 'Revenues' (FY2016-2017) and 'RevenueFromContractWithCustomerExcludingAssessedTax' (FY2018-2023) due to accounting standard change (ASC 606)"),
        tags$li(tags$strong("Margins:"), " Calculated as ratios of reported values (e.g., Operating Margin = Operating Income / Revenue)"),
        tags$li(tags$strong("FCF Proxy:"), " Operating Cash Flow - Capital Expenditures"),
        tags$li(tags$strong("Growth Rates:"), " Year-over-year percentage change"),
        tags$li(tags$strong("Capital Efficiency:"), " Revenue / Total Assets")
      ),
      
      tags$h4("Segment Data", style = "color: #323130; margin-top: 1.5em;"),
      tags$p("Segment revenue extracted from 10-K Item 1 - Business, Segment Information disclosures. Revenue-only (no segment margin estimation).", 
             style = "color: #605E5C;"),
      
      tags$h4("Disclaimers", style = "color: #323130; margin-top: 1.5em;"),
      tags$p(
        style = "color: #605E5C; line-height: 1.6;",
        tags$strong("This dashboard is an independent analytical exercise."), 
        " Figures are simplified and re-aggregated for illustrative purposes only and do not represent official company reporting, forecasts, or investment advice."
      )
    )
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_data_explorer_server <- function(id, financials, segments) {
  moduleServer(id, function(input, output, session) {
    
    # --- Data Table ---
    
    output$table_financials <- renderReactable({
      reactable(
        financials,
        columns = list(
          fiscal_year = colDef(name = "Fiscal Year", minWidth = 80, align = "center"),
          revenue = colDef(name = "Revenue", format = colFormat(prefix = "$", separators = TRUE, digits = 0)),
          gross_margin = colDef(name = "Gross Margin", format = colFormat(percent = TRUE, digits = 1)),
          operating_margin = colDef(name = "Operating Margin", format = colFormat(percent = TRUE, digits = 1)),
          net_margin = colDef(name = "Net Margin", format = colFormat(percent = TRUE, digits = 1)),
          revenue_growth = colDef(name = "Revenue Growth", format = colFormat(percent = TRUE, digits = 1)),
          cfo = colDef(name = "Operating CF", format = colFormat(prefix = "$", separators = TRUE, digits = 0)),
          fcf_proxy = colDef(name = "FCF (Proxy)", format = colFormat(prefix = "$", separators = TRUE, digits = 0)),
          fcf_margin = colDef(name = "FCF Margin", format = colFormat(percent = TRUE, digits = 1)),
          total_assets = colDef(name = "Total Assets", format = colFormat(prefix = "$", separators = TRUE, digits = 0)),
          cash = colDef(name = "Cash", format = colFormat(prefix = "$", separators = TRUE, digits = 0)),
          revenue_per_asset = colDef(name = "Revenue/Asset", format = colFormat(digits = 2)),
          debt_to_equity = colDef(name = "Debt/Equity", format = colFormat(digits = 2))
        ),
        searchable = TRUE,
        filterable = TRUE,
        defaultPageSize = 10,
        highlight = TRUE,
        bordered = TRUE,
        striped = TRUE,
        theme = reactableTheme(
          borderColor = "#E1DFDD",
          stripedColor = "#F3F2F1",
          highlightColor = "#E1F5FE",
          cellPadding = "10px 12px",
          style = list(
            fontFamily = "Segoe UI, -apple-system, sans-serif",
            fontSize = "14px"
          ),
          headerStyle = list(
            backgroundColor = "#F3F2F1",
            color = "#323130",
            fontWeight = 600,
            borderBottom = "2px solid #0078D4"
          )
        )
      )
    })
    
    # --- Download Handler ---
    
    output$download_csv <- downloadHandler(
      filename = function() {
        paste0("microsoft_financials_", Sys.Date(), ".csv")
      },
      content = function(file) {
        write.csv(financials, file, row.names = FALSE)
      }
    )
    
  })
}