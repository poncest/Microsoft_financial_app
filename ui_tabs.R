# ==============================================================================
# UI - Tab Definitions
# Author: Steven Ponce
# ==============================================================================

# --- Tab 1: Executive Brief ---------------------------------------------------

tab_executive <- tabItem(
  tabName = "executive",
  
  h2("Executive Brief", style = paste0("color: ", msft_colors$dark, ";")),
  p("High-level financial performance summary (FY2016–FY2023)", 
    style = paste0("color: ", msft_colors$medium, ";")),
  
  # KPI Cards Row
  div(
    class = "ui five cards",
    style = "margin-top: 2em;",
    
    # Card 1: Revenue
    div(
      class = "ui card",
      div(
        class = "content",
        style = "text-align: center; padding: 2em 1em;",
        div(
          style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$primary, ";"),
          textOutput("kpi_revenue", inline = TRUE)
        ),
        div(
          style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
          "FY2023 Revenue"
        )
      )
    ),
    
    # Card 2: Gross Margin
    div(
      class = "ui card",
      div(
        class = "content",
        style = "text-align: center; padding: 2em 1em;",
        div(
          style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$success, ";"),
          textOutput("kpi_gross_margin", inline = TRUE)
        ),
        div(
          style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
          "Gross Margin"
        )
      )
    ),
    
    # Card 3: Operating Margin
    div(
      class = "ui card",
      div(
        class = "content",
        style = "text-align: center; padding: 2em 1em;",
        div(
          style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$success, ";"),
          textOutput("kpi_operating_margin", inline = TRUE)
        ),
        div(
          style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
          "Operating Margin"
        )
      )
    ),
    
    # Card 4: FCF
    div(
      class = "ui card",
      div(
        class = "content",
        style = "text-align: center; padding: 2em 1em;",
        div(
          style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$primary, ";"),
          textOutput("kpi_fcf", inline = TRUE)
        ),
        div(
          style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
          "Free Cash Flow (Proxy)"
        )
      )
    ),
    
    # Card 5: Revenue Growth
    div(
      class = "ui card",
      div(
        class = "content",
        style = "text-align: center; padding: 2em 1em;",
        div(
          style = paste0("font-size: 2.5em; font-weight: bold; color: ", msft_colors$chart_2, ";"),
          textOutput("kpi_growth", inline = TRUE)
        ),
        div(
          style = paste0("font-size: 0.9em; color: ", msft_colors$medium, "; margin-top: 0.5em;"),
          "Revenue Growth (YoY)"
        )
      )
    )
  ),
  
  # Trend Chart
  div(
    class = "ui segment",
    style = "margin-top: 2em; padding: 2em;",
    h3("Revenue & Operating Margin Trend", style = paste0("color: ", msft_colors$dark, ";")),
    girafeOutput("chart_executive_trend", height = "400px")
  ),
  
  # Key Insight
  div(
    class = "ui message",
    style = "margin-top: 2em;",
    div(class = "header", "Key Insight"),
    p(uiOutput("executive_insight"))
  )
)

# --- Placeholder tabs (we'll build these next) --------------------------------

tab_growth <- tabItem(
  tabName = "growth",
  h2("Growth & Mix"),
  p("Coming next...")
)

tab_profitability <- tabItem(
  tabName = "profitability",
  h2("Profitability Drivers"),
  p("Coming next...")
)

tab_cash <- tabItem(
  tabName = "cash",
  h2("Cash Engine"),
  p("Coming next...")
)

tab_balance_sheet <- tabItem(
  tabName = "balance_sheet",
  h2("Balance Sheet & Capital"),
  p("Coming next...")
)

tab_data_explorer <- tabItem(
  tabName = "data_explorer",
  h2("Data Explorer"),
  p("Coming next...")
)