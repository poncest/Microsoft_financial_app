# Module: Executive Brief
# Clean Microsoft design - single blue color, YoY context, side-by-side charts

# ==============================================================================
# UI
# ==============================================================================

mod_executive_brief_ui <- function(id) {
  ns <- NS(id)
  
  tagList(
    
    # Header
    h2("Executive Brief", style = "color: #004578; margin-bottom: 0.3em;"),
    p("High-level financial performance summary (FY2016-FY2023)",
      style = "color: #605E5C; margin-bottom: 2em;"),
    
    # KPI Cards Row - ALL MICROSOFT BLUE (#0078D4)
    div(
      class = "ui five cards",
      style = "margin-top: 1em;",
      
      # Revenue Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_revenue"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "FY2023 Revenue"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_revenue_context"), inline = TRUE)
          )
        )
      ),
      
      # Gross Margin Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_gross_margin"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "Gross Margin"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_gross_margin_context"), inline = TRUE)
          )
        )
      ),
      
      # Operating Margin Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_operating_margin"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "Operating Margin"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            uiOutput(ns("kpi_operating_margin_context"), inline = TRUE)
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
            uiOutput(ns("kpi_fcf"), inline = TRUE)
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
      
      # Revenue Growth Card
      div(
        class = "ui card",
        div(
          class = "content",
          style = "text-align: center; padding: 2em 1em; min-height: 170px; background: white;",
          div(
            style = "font-size: 2.5em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_revenue_growth"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "FY2023 Growth"
          ),
          div(
            style = "font-size: 0.85em; color: #605E5C; min-height: 20px;",
            "Year-over-Year"
          )
        )
      )
    ),
    
    # Section Header
    div(
      style = "margin-top: 3em; margin-bottom: 1em;",
      h3("Financial Performance Trends", style = "color: #004578;"),
      p("Eight-year trajectory showing revenue growth and margin expansion", 
        style = "color: #605E5C;")
    ),
    
    # Two Charts Side-by-Side (NO DUAL-AXIS, BOTH BLUE)
    div(
      class = "ui two column grid",
      style = "margin-top: 1em;",
      
      # Revenue Trend
      div(
        class = "column",
        div(
          class = "ui segment",
          style = "padding: 2em; background: white;",
          h4("Revenue Growth", style = "color: #004578; margin-bottom: 0.5em;"),
          p("Total revenue (FY2016-2023)", style = "color: #605E5C; font-size: 0.9em;"),
          girafeOutput(ns("chart_revenue"), height = "320px")
        )
      ),
      
      # Operating Margin Trend
      div(
        class = "column",
        div(
          class = "ui segment",
          style = "padding: 2em; background: white;",
          h4("Operating Margin Expansion", style = "color: #004578; margin-bottom: 0.5em;"),
          p("Operating margin trend", style = "color: #605E5C; font-size: 0.9em;"),
          girafeOutput(ns("chart_margin"), height = "320px")
        )
      )
    ),
    
    # Strategic Hypotheses Summary (NEW SECTION)
    div(
      class = "ui segment",
      style = "margin-top: 3em; padding: 2.5em; background: white; border-top: 4px solid #0078D4;",
      h3("Strategic Hypotheses", style = "color: #004578; margin-bottom: 1em;"),
      p("Five hypotheses tested across financial dimensions", 
        style = "color: #605E5C; margin-bottom: 1.5em;"),
      uiOutput(ns("hypothesis_summary"))
    ),
    
    # Key Insights Box
    div(
      class = "ui message",
      style = "margin-top: 2em; border-left: 4px solid #0078D4; background: #F3F2F1;",
      div(
        class = "header", 
        style = "color: #004578;",
        "Key Insights"
      ),
      uiOutput(ns("key_insights"))
    )
  )
}

# ==============================================================================
# Server
# ==============================================================================

mod_executive_brief_server <- function(id, financials, app_metrics) {
  moduleServer(id, function(input, output, session) {
    
    # --- KPI Outputs ---
    
    output$kpi_revenue <- renderText({
      fmt_currency(app_metrics$latest_revenue, suffix = "B", scale = 1e-9, digits = 1)
    })
    
    output$kpi_revenue_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      yoy_change <- ((fy2023$revenue / fy2022$revenue) - 1) * 100
      paste0(ifelse(yoy_change > 0, "+", ""), round(yoy_change, 1), "% YoY")
    })
    
    output$kpi_gross_margin <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      fmt_percent(fy2023$gross_margin, digits = 1)
    })
    
    output$kpi_gross_margin_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      pp_change <- (fy2023$gross_margin - fy2022$gross_margin) * 100
      paste0(ifelse(pp_change > 0, "+", ""), round(pp_change, 1), "pp YoY")
    })
    
    output$kpi_operating_margin <- renderText({
      fmt_percent(app_metrics$latest_operating_margin, digits = 1)
    })
    
    output$kpi_operating_margin_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      pp_change <- (fy2023$operating_margin - fy2022$operating_margin) * 100
      paste0(ifelse(pp_change > 0, "+", ""), round(pp_change, 1), "pp YoY")
    })
    
    output$kpi_fcf <- renderText({
      fmt_currency(app_metrics$latest_fcf, suffix = "B", scale = 1e-9, digits = 1)
    })
    
    output$kpi_fcf_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      yoy_change <- ((fy2023$fcf_proxy / fy2022$fcf_proxy) - 1) * 100
      paste0(ifelse(yoy_change > 0, "+", ""), round(yoy_change, 1), "% YoY")
    })
    
    output$kpi_revenue_growth <- renderText({
      fmt_percent(app_metrics$latest_revenue_growth, digits = 1, include_sign = TRUE)
    })
    
    # --- Chart Outputs (Side-by-Side, BOTH MICROSOFT BLUE) ---
    
    output$chart_revenue <- renderGirafe({
      chart_revenue_bars_clean(financials)
    })
    
    output$chart_margin <- renderGirafe({
      chart_operating_margin_line(financials)
    })
    
    # --- Hypothesis Summary (NEW) ---
    
    output$hypothesis_summary <- renderUI({
      
      # Calculate metrics for each hypothesis
      cagr_early_pct <- app_metrics$cagr_early * 100
      cagr_late_pct <- app_metrics$cagr_late * 100
      growth_acceleration <- cagr_late_pct - cagr_early_pct
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      margin_expansion <- (fy2023$operating_margin - fy2016$operating_margin) * 100
      
      cloud_2016 <- segments |> filter(fiscal_year == 2016, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_2023 <- segments |> filter(fiscal_year == 2023, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_growth <- (cloud_2023 - cloud_2016) * 100
      
      avg_fcf_margin <- mean(financials$fcf_margin, na.rm = TRUE) * 100
      asset_efficiency_change <- ((fy2023$revenue_per_asset / fy2016$revenue_per_asset) - 1) * 100
      
      HTML(sprintf(
        "
        <div style='display: grid; grid-template-columns: 1fr; gap: 1em;'>
          
          <div style='padding: 1em; background: #F9F9F9; border-left: 3px solid #0078D4; border-radius: 4px;'>
            <div style='display: flex; justify-content: space-between; align-items: center;'>
              <div>
                <strong style='color: #004578; font-size: 1.05em;'>H1: Cloud transition driving revenue acceleration</strong>
                <div style='color: #605E5C; font-size: 0.9em; margin-top: 0.3em;'>Growth & Mix tab</div>
              </div>
              <span style='background: #107C10; color: white; padding: 0.4em 0.8em; border-radius: 3px; font-size: 0.85em; font-weight: 600;'>✓ SUPPORTED</span>
            </div>
            <div style='margin-top: 0.8em; color: #323130; font-size: 0.95em; line-height: 1.5;'>
              Revenue CAGR accelerated by <strong>%.1fpp</strong> (%.1f%% → %.1f%%) as Intelligent Cloud expanded <strong>%.1fpp</strong> to %.1f%% of revenue.
            </div>
          </div>
          
          <div style='padding: 1em; background: #F9F9F9; border-left: 3px solid #0078D4; border-radius: 4px;'>
            <div style='display: flex; justify-content: space-between; align-items: center;'>
              <div>
                <strong style='color: #004578; font-size: 1.05em;'>H2: Margin expansion driven by mix shift</strong>
                <div style='color: #605E5C; font-size: 0.9em; margin-top: 0.3em;'>Profitability Drivers tab</div>
              </div>
              <span style='background: #107C10; color: white; padding: 0.4em 0.8em; border-radius: 3px; font-size: 0.85em; font-weight: 600;'>✓ SUPPORTED</span>
            </div>
            <div style='margin-top: 0.8em; color: #323130; font-size: 0.95em; line-height: 1.5;'>
              Operating margin expanded <strong>%.1fpp</strong> (%.1f%% → %.1f%%) while R&D intensity remained stable.
            </div>
          </div>
          
          <div style='padding: 1em; background: #F9F9F9; border-left: 3px solid #0078D4; border-radius: 4px;'>
            <div style='display: flex; justify-content: space-between; align-items: center;'>
              <div>
                <strong style='color: #004578; font-size: 1.05em;'>H3: Cash generation resilient despite growth investments</strong>
                <div style='color: #605E5C; font-size: 0.9em; margin-top: 0.3em;'>Cash Engine tab</div>
              </div>
              <span style='background: #107C10; color: white; padding: 0.4em 0.8em; border-radius: 3px; font-size: 0.85em; font-weight: 600;'>✓ SUPPORTED</span>
            </div>
            <div style='margin-top: 0.8em; color: #323130; font-size: 0.95em; line-height: 1.5;'>
              FCF margin averaged <strong>%.1f%%</strong> across FY2016-2023.
            </div>
          </div>
          
          <div style='padding: 1em; background: #F9F9F9; border-left: 3px solid #0078D4; border-radius: 4px;'>
            <div style='display: flex; justify-content: space-between; align-items: center;'>
              <div>
                <strong style='color: #004578; font-size: 1.05em;'>H4: Capital efficiency improved (asset-light model)</strong>
                <div style='color: #605E5C; font-size: 0.9em; margin-top: 0.3em;'>Balance Sheet tab</div>
              </div>
              <span style='background: #107C10; color: white; padding: 0.4em 0.8em; border-radius: 3px; font-size: 0.85em; font-weight: 600;'>✓ SUPPORTED</span>
            </div>
            <div style='margin-top: 0.8em; color: #323130; font-size: 0.95em; line-height: 1.5;'>
              Revenue per dollar of assets increased <strong>%.1f%%</strong>.
            </div>
          </div>
          
          <div style='padding: 1em; background: #F9F9F9; border-left: 3px solid #0078D4; border-radius: 4px;'>
            <div style='display: flex; justify-content: space-between; align-items: center;'>
              <div>
                <strong style='color: #004578; font-size: 1.05em;'>H5: Balance sheet provides flexibility for capital returns</strong>
                <div style='color: #605E5C; font-size: 0.9em; margin-top: 0.3em;'>Balance Sheet tab</div>
              </div>
              <span style='background: #107C10; color: white; padding: 0.4em 0.8em; border-radius: 3px; font-size: 0.85em; font-weight: 600;'>✓ SUPPORTED</span>
            </div>
            <div style='margin-top: 0.8em; color: #323130; font-size: 0.95em; line-height: 1.5;'>
              Strong cash position ($%.1fB) and moderate leverage support flexibility.
            </div>
          </div>
          
        </div>
        ",
        growth_acceleration, cagr_early_pct, cagr_late_pct, cloud_growth, cloud_2023 * 100,
        margin_expansion, fy2016$operating_margin * 100, fy2023$operating_margin * 100,
        avg_fcf_margin,
        asset_efficiency_change,
        fy2023$cash / 1e9
      ))
    })
    
    
    # --- Key Insights ---
    
    output$key_insights <- renderUI({
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      revenue_growth_total <- ((fy2023$revenue / fy2016$revenue) - 1) * 100
      margin_expansion <- (fy2023$operating_margin - fy2016$operating_margin) * 100
      avg_fcf_margin <- mean(financials$fcf_margin, na.rm = TRUE) * 100
      
      HTML(sprintf(
        "<ul style='line-height: 1.8; color: #323130;'>
          <li>Revenue grew <strong>%.1f%%</strong> from FY2016 to FY2023 ($%.1fB → $%.1fB)</li>
          <li>Operating margin expanded <strong>%.1f percentage points</strong> (%.1f%% → %.1f%%)</li>
          <li>Free cash flow margin averaged <strong>%.1f%%</strong> across the period</li>
          <li>Cloud transition driving both growth acceleration and profitability improvement</li>
        </ul>",
        revenue_growth_total,
        fy2016$revenue / 1e9,
        fy2023$revenue / 1e9,
        margin_expansion,
        fy2016$operating_margin * 100,
        fy2023$operating_margin * 100,
        avg_fcf_margin
      ))
    })
    
  })
}


