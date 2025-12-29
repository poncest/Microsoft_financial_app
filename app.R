# Microsoft Financial Analysis Dashboard
# Professional financial analysis with Appsilon stack
# Portfolio project by Steven Ponce

# ==============================================================================
# Source Global Setup
# ==============================================================================
source("global.R")

# ==============================================================================
# UI
# ==============================================================================
ui <- semanticPage(
  
  # Custom CSS
  tags$head(
    tags$style(HTML(paste0("
      body {
        background-color: ", msft_colors$background, " !important;
        font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
      }
      .ui.menu {
        background-color: ", msft_colors$dark, " !important;
        margin-bottom: 0 !important;
      }
      .ui.vertical.menu {
        background-color: #323130 !important;
      }
      .main-content {
        padding: 20px;
      }
      .ui.segment {
        box-shadow: 0 1px 3px rgba(0,0,0,0.08);
      }
    ")))
  ),
  
  # Initialize shinyjs and waiter
  shinyjs::useShinyjs(),
  waiter::use_waiter(),
  
  # *** NEW: Loading Spinner Configuration ***
  waiter::waiter_show_on_load(
    html = tagList(
      waiter::spin_fading_circles(),
      h3("Loading Dashboard...", style = "color: #0078D4; margin-top: 1em;")
    ),
    color = "#F3F2F1"
  ),
  
  # About Modal
  div(
    class = "ui modal about",
    div(
      class = "header",
      style = paste0("background: ", msft_colors$primary, "; color: white;"),
      icon("circle-info"),
      " About This Dashboard"
    ),
    div(
      class = "content",
      
      tags$h3("Purpose"),
      tags$p(
        "Strategic financial analysis of Microsoft Corporation demonstrating data engineering from official SEC sources and hypothesis-driven analytics for portfolio presentation."
      ),
      
      tags$h3("Data Sources"),
      tags$ul(
        tags$li(tags$strong("Primary:"), " SEC EDGAR XBRL Company Facts API"),
        tags$li(tags$strong("Company:"), " Microsoft Corporation (CIK 0000789019)"),
        tags$li(tags$strong("Filings:"), " Annual 10-K reports (FY2016–FY2023)"),
        tags$li(tags$strong("Segments:"), " Extracted from Item 1 - Business disclosures")
      ),
      
      tags$h3("How to Use"),
      tags$ul(
        tags$li(tags$strong("Executive Brief:"), " High-level KPIs and financial trends for quick assessment"),
        tags$li(tags$strong("Growth & Mix:"), " Revenue acceleration analysis and segment composition shifts"),
        tags$li(tags$strong("Profitability Drivers:"), " Margin expansion and R&D intensity analysis"),
        tags$li(tags$strong("Cash Engine:"), " Operating cash flow and free cash flow generation"),
        tags$li(tags$strong("Balance Sheet:"), " Capital efficiency and balance sheet strength metrics"),
        tags$li(tags$strong("Data Explorer:"), " Full dataset with filters and CSV export")
      ),
      
      tags$h3("Hypotheses Tested"),
      tags$ul(
        tags$li(tags$strong("H1:"), " Revenue growth accelerated (cloud transition effect)"),
        tags$li(tags$strong("H2:"), " Margin expansion driven by mix shift, not cost compression"),
        tags$li(tags$strong("H3:"), " Cash generation remains resilient despite growth investments"),
        tags$li(tags$strong("H4:"), " Capital efficiency improved (asset-light model)"),
        tags$li(tags$strong("H5:"), " Balance sheet provides flexibility for capital returns")
      ),
      
      tags$h3("Disclaimer"),
      tags$p(tags$strong("This is a portfolio project."), " Figures are simplified and re-aggregated from SEC filings for analytical purposes. This dashboard does not constitute investment advice, financial forecasts, or official company reporting."),
      
      tags$h3("Technology Stack"),
      tags$p(
        tags$strong("Built with:"), " R Shiny, Appsilon stack (shiny.semantic, ggiraph, reactable), SEC EDGAR API"
      ),
      
      # Links
      div(
        style = "margin-top: 2em; display: flex; gap: 1em; flex-wrap: wrap;",
        tags$a(
          class = "ui button",
          style = paste0("background: ", msft_colors$primary, "; color: white;"),
          href = "https://github.com/poncest/Microsoft_financial_app",
          target = "_blank",
          icon("github"), " GitHub"
        ),
        tags$a(
          class = "ui button",
          style = paste0("background: ", msft_colors$primary, "; color: white;"),
          href = "https://www.linkedin.com/in/steven-ponce/",
          target = "_blank",
          icon("linkedin"), " LinkedIn"
        )
      )
    ),
    div(
      class = "actions",
      tags$button(
        class = "ui primary button",
        onclick = "$('.ui.modal.about').modal('hide');",
        "Close"
      )
    )
  ),
  
  # Top Navigation Menu
  div(
    class = "ui inverted menu",
    style = "margin: 0; border-radius: 0;",
    div(
      class = "header item", 
      style = "font-size: 1.3em; font-weight: 600;",
      icon("chart-line"),
      " Microsoft Financial Analysis"
    ),
    div(
      class = "right menu",
      div(
        class = "item", 
        style = "font-size: 0.9em;",
        "v1.0.0 | FY2016-2023"
      )
    )
  ),
  
  # About button (below header)
  div(
    style = "padding: 15px 20px; background: #323130;",
    tags$button(
      class = "ui fluid button",
      style = paste0("background: ", msft_colors$primary, "; color: white;"),
      onclick = "$('.ui.modal.about').modal('show');",
      icon("circle-info"),
      " About"
    )
  ),
  
  # Sidebar Layout
  div(
    class = "ui grid",
    style = "margin: 0; min-height: 100vh;",
    
    # Sidebar (3 wide)
    div(
      class = "three wide column",
      style = "padding: 0; background: #323130; min-height: 100vh;",
      div(
        class = "ui vertical inverted menu",
        style = "width: 100%; margin: 0; border-radius: 0;",
        
        uiOutput("sidebar_menu")
      )
    ),
    
    # Main Content (13 wide)
    div(
      class = "thirteen wide column main-content",
      
      uiOutput("main_content")
    )
  ),
  
  # Footer
  tags$footer(
    class = "main-footer",
    style = paste0("
      position: relative;
      left: 50%;
      right: 50%;
      margin-left: -50vw;
      margin-right: -50vw;
      width: 100vw;
      background: #323130;
      color: #B0B0B0;
      padding: 2em 0;
      margin-top: 4em;
      text-align: center;
    "),
    div(
      class = "container",
      # App title and tech stack
      div(
        style = "margin-bottom: 1em; font-size: 0.95em;",
        "Microsoft Financial Analysis Dashboard | Built with Appsilon Stack | Data: FY2016-2023"
      ),
      # Copyright
      div(
        style = "margin-bottom: 1em; font-size: 0.9em; color: #999;",
        "© 2025 Steven Ponce | Portfolio Project | v1.0 · Dec 2025"
      ),
      # Social links
      div(
        style = "display: flex; justify-content: center; gap: 2em; margin-top: 1em; flex-wrap: wrap;",
        tags$a(
          href = "https://github.com/poncest",
          target = "_blank",
          style = "color: #B0B0B0; text-decoration: none; font-size: 1.1em;",
          icon("github"), " GitHub"
        ),
        tags$a(
          href = "https://www.linkedin.com/in/steven-ponce/",
          target = "_blank",
          style = "color: #B0B0B0; text-decoration: none; font-size: 1.1em;",
          icon("linkedin"), " LinkedIn"
        ),
        tags$a(
          href = "https://stevenponce.netlify.app/",
          target = "_blank",
          style = "color: #B0B0B0; text-decoration: none; font-size: 1.1em;",
          icon("briefcase"), " Portfolio"
        )
      )
    )
  )
)

# ==============================================================================
# Server
# ==============================================================================
server <- function(input, output, session) {
  
  # *** NEW: Hide loading spinner once app is ready ***
  waiter::waiter_hide()
  
  # Reactive value for current tab
  current_tab <- reactiveVal("executive")
  
  # Sidebar menu
  output$sidebar_menu <- renderUI({
    tagList(
      div(
        class = if (current_tab() == "executive") "active item" else "item",
        style = "cursor: pointer;",
        onclick = "Shiny.setInputValue('selected_tab', 'executive');",
        icon("dashboard"),
        " Executive Brief"
      ),
      div(
        class = if (current_tab() == "growth") "active item" else "item",
        style = "cursor: pointer;",
        onclick = "Shiny.setInputValue('selected_tab', 'growth');",
        icon("area graph"), # not rendering
        " Growth & Mix"
      ),
      div(
        class = if (current_tab() == "profitability") "active item" else "item",
        style = "cursor: pointer;",
        onclick = "Shiny.setInputValue('selected_tab', 'profitability');",
        icon("percentage"),
        " Profitability Drivers"
      ),
      div(
        class = if (current_tab() == "cash") "active item" else "item",
        style = "cursor: pointer;",
        onclick = "Shiny.setInputValue('selected_tab', 'cash');",
        icon("coins"),
        " Cash Engine"
      ),
      div(
        class = if (current_tab() == "balance_sheet") "active item" else "item",
        style = "cursor: pointer;",
        onclick = "Shiny.setInputValue('selected_tab', 'balance_sheet');",
        icon("clipboard"),   
        " Balance Sheet"
      ),
      div(
        class = if (current_tab() == "data_explorer") "active item" else "item",
        style = "cursor: pointer;",
        onclick = "Shiny.setInputValue('selected_tab', 'data_explorer');",
        icon("table"),
        " Data Explorer"
      )
    )
  })
  
  # Update current tab
  observeEvent(input$selected_tab, {
    current_tab(input$selected_tab)
  })
  
  # Main content (render appropriate tab)
  output$main_content <- renderUI({
    req(current_tab())
    
    switch(current_tab(),
           "executive" = mod_executive_brief_ui("executive_brief"),
           "growth" = mod_growth_mix_ui("growth_mix"),
           "profitability" = mod_profitability_ui("profitability"),
           "cash" = mod_cash_engine_ui("cash_engine"),
           "balance_sheet" = mod_balance_sheet_ui("balance_sheet"),
           "data_explorer" = mod_data_explorer_ui("data_explorer")
    )
  })
  
  # Module servers
  # *** UPDATED: Added segments data to executive brief call ***
  mod_executive_brief_server("executive_brief", financials, segments, app_metrics)
  mod_growth_mix_server("growth_mix", financials, segments, app_metrics)
  mod_profitability_server("profitability", financials)
  mod_cash_engine_server("cash_engine", financials)
  mod_balance_sheet_server("balance_sheet", financials)
  mod_data_explorer_server("data_explorer", financials, segments)
  
}

# Run app
shinyApp(ui = ui, server = server)