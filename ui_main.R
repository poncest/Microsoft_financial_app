# ==============================================================================
# UI - Main Dashboard Structure
# Author: Steven Ponce
# ==============================================================================

ui <- dashboardPage(
  
  # --- Dashboard Header -------------------------------------------------------
  
  dashboardHeader(
    title = "Microsoft Financial Analysis",
    color = "blue"
  ),
  
  # --- Sidebar ----------------------------------------------------------------
  
  dashboardSidebar(
    size = "thin",
    color = "blue",
    sidebarMenu(
      menuItem(
        tabName = "executive",
        text = "Executive Brief",
        icon = icon("chart line")
      ),
      menuItem(
        tabName = "growth",
        text = "Growth & Mix",
        icon = icon("arrow up")
      ),
      menuItem(
        tabName = "profitability",
        text = "Profitability Drivers",
        icon = icon("percent")
      ),
      menuItem(
        tabName = "cash",
        text = "Cash Engine",
        icon = icon("dollar sign")
      ),
      menuItem(
        tabName = "balance_sheet",
        text = "Balance Sheet & Capital",
        icon = icon("balance scale")
      ),
      menuItem(
        tabName = "data_explorer",
        text = "Data Explorer",
        icon = icon("table")
      ),
      
      # --- About Button (Modal Trigger) ---------------------------------------
      
      div(
        style = "padding: 20px 15px;",
        actionButton(
          "show_about",
          "About This Dashboard",
          icon = icon("info circle"),
          class = "ui fluid button",
          onclick = "$('.ui.modal.about').modal('show');"
        )
      )
    )
  ),
  
  # --- Dashboard Body ---------------------------------------------------------
  
  dashboardBody(
    
    # Custom CSS
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
    ),
    
    # Tab items
    tabItems(
      tab_executive,
      tab_growth,
      tab_profitability,
      tab_cash,
      tab_balance_sheet,
      tab_data_explorer
    ),
    
    # --- About Modal ----------------------------------------------------------
    
    div(
      class = "ui modal about",
      div(
        class = "header",
        "About This Dashboard"
      ),
      div(
        class = "content",
        
        h3("Purpose"),
        p("This dashboard is an independent analytical exercise using publicly available financial disclosures from Microsoft Corporation (CIK 0000789019). The objective is to demonstrate analytical rigor, decision-support design, and transparent data engineering for a portfolio showcase."),
        
        h3("Data Sources"),
        tags$ul(
          tags$li("SEC EDGAR XBRL Company Facts API"),
          tags$li("Microsoft 10-K annual filings (FY2016–FY2023)"),
          tags$li("Segment revenue from Item 1 disclosures")
        ),
        
        h3("Hypotheses"),
        tags$ol(
          tags$li("Revenue growth accelerated in the latter period, coinciding with Microsoft's cloud transition."),
          tags$li("Margin expansion reflects revenue mix shifts more than broad-based cost compression."),
          tags$li("Cash generation remains strong despite growth investments."),
          tags$li("Revenue per dollar of assets has increased, indicating improving capital efficiency."),
          tags$li("Balance sheet strength provides flexibility for capital returns and reinvestment.")
        ),
        
        h3("Disclaimers"),
        p(strong("This is not:"), " Official company reporting, investment advice, forward-looking guidance, or a valuation model. Figures are simplified and re-aggregated for illustrative purposes only."),
        
        h3("Technical Stack"),
        tags$ul(
          tags$li("R + Shiny (Appsilon framework)"),
          tags$li("Data: httr2, jsonlite, dplyr, tidyr"),
          tags$li("Visualization: ggplot2, ggiraph, reactable")
        ),
        
        h3("Contact"),
        p(
          "Created by Steven Ponce | ",
          tags$a(href = "https://github.com/yourusername", "GitHub", target = "_blank"),
          " | ",
          tags$a(href = "https://linkedin.com/in/yourprofile", "LinkedIn", target = "_blank")
        )
      ),
      div(
        class = "actions",
        div(class = "ui button", "Close")
      )
    )
  )
)