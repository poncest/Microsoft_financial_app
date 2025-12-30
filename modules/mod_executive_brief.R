# Module: Executive Brief
# Clean Microsoft design with inline formatting (no helper function dependencies)
# NOW WITH ALL 5 HYPOTHESIS BOXES

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
            style = "font-size: 2.3em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
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
            style = "font-size: 2.3em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
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
            style = "font-size: 2.3em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
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
            style = "font-size: 2.3em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
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
            style = "font-size: 2.3em; font-weight: 700; color: #0078D4; margin-bottom: 0.2em;",
            uiOutput(ns("kpi_revenue_growth"), inline = TRUE)
          ),
          div(
            style = "font-size: 0.9em; color: #323130; margin-bottom: 0.5em; font-weight: 500;",
            "FY2023 YoY Growth"
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
    
    # Two Charts Side-by-Side
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
    
    # STRATEGIC HYPOTHESES SECTION
    div(
      style = "margin-top: 3em; padding: 2em; background: white; border-radius: 4px; border: 1px solid #E1DFDD;",
      
      h3("Strategic Hypotheses", style = "color: #004578; margin-bottom: 1em; border-bottom: 2px solid #0078D4; padding-bottom: 0.5em;"),
      
      uiOutput(ns("all_hypotheses")),
      
      div(
        style = "margin-top: 1.5em; font-size: 0.85em; color: #605E5C; font-style: italic;",
        "Hypotheses are evaluated using consolidated historical financial disclosures. ",
        "Results indicate directional alignment with stated hypotheses, not causal attribution."
      )
      
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

mod_executive_brief_server <- function(id, financials, segments, app_metrics) {
  moduleServer(id, function(input, output, session) {
    
    # --- KPI Outputs (inline formatting) ---
    
    output$kpi_revenue <- renderText({
      paste0("$", round(app_metrics$latest_revenue / 1e9, 1), "B")
    })
    
    output$kpi_revenue_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      yoy_change <- ((fy2023$revenue / fy2022$revenue) - 1) * 100
      paste0(ifelse(yoy_change > 0, "+", ""), round(yoy_change, 1), "% YoY")
    })
    
    output$kpi_gross_margin <- renderText({
      fy2023 <- financials |> filter(fiscal_year == 2023)
      paste0(round(fy2023$gross_margin * 100, 1), "%")
    })
    
    output$kpi_gross_margin_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      pp_change <- (fy2023$gross_margin - fy2022$gross_margin) * 100
      paste0(ifelse(pp_change > 0, "+", ""), round(pp_change, 1), "pp YoY")
    })
    
    output$kpi_operating_margin <- renderText({
      paste0(round(app_metrics$latest_operating_margin * 100, 1), "%")
    })
    
    output$kpi_operating_margin_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      pp_change <- (fy2023$operating_margin - fy2022$operating_margin) * 100
      paste0(ifelse(pp_change > 0, "+", ""), round(pp_change, 1), "pp YoY")
    })
    
    output$kpi_fcf <- renderText({
      paste0("$", round(app_metrics$latest_fcf / 1e9, 1), "B")
    })
    
    output$kpi_fcf_context <- renderText({
      fy2022 <- financials |> filter(fiscal_year == 2022)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      yoy_change <- ((fy2023$fcf_proxy / fy2022$fcf_proxy) - 1) * 100
      paste0(ifelse(yoy_change > 0, "+", ""), round(yoy_change, 1), "% YoY")
    })
    
    output$kpi_revenue_growth <- renderText({
      growth_val <- app_metrics$latest_revenue_growth * 100
      sign <- if(growth_val > 0) "+" else ""
      paste0(sign, round(growth_val, 1), "%")
    })
    
    # --- Chart Outputs ---
    
    output$chart_revenue <- renderGirafe({
      chart_revenue_bars_clean(financials)
    })
    
    output$chart_margin <- renderGirafe({
      chart_operating_margin_line(financials)
    })
    
    # --- ALL 5 HYPOTHESES ---
    
    output$all_hypotheses <- renderUI({
      
      fy2016 <- financials |> filter(fiscal_year == 2016)
      fy2023 <- financials |> filter(fiscal_year == 2023)
      
      # H1 metrics
      cagr_early_pct <- app_metrics$cagr_early * 100
      cagr_late_pct <- app_metrics$cagr_late * 100
      cagr_acceleration <- cagr_late_pct - cagr_early_pct
      
      cloud_2016 <- segments |> filter(fiscal_year == 2016, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_2023 <- segments |> filter(fiscal_year == 2023, segment == "Intelligent Cloud") |> pull(pct_of_total)
      cloud_change <- (cloud_2023 - cloud_2016) * 100
      
      # H2 metrics
      op_margin_expansion <- (fy2023$operating_margin - fy2016$operating_margin) * 100
      avg_rnd <- mean(financials$rnd_intensity, na.rm = TRUE) * 100
      
      # H3 metrics
      avg_fcf_margin <- mean(financials$fcf_margin, na.rm = TRUE) * 100
      
      # H4 metrics
      rev_per_asset_change <- ((fy2023$revenue_per_asset / fy2016$revenue_per_asset) - 1) * 100
      
      # H5 metrics
      cash_2023 <- fy2023$cash / 1e9
      
      tagList(
        # H1
        div(
          style = "margin-bottom: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
          div(
            style = "display: flex; justify-content: space-between; align-items: center;",
            div(
              style = "flex: 1;",
              h4("H1: Revenue acceleration coincides with increased cloud mix", 
                 style = "color: #004578; margin-bottom: 0.5em;"),
              div(style = "color: #605E5C; font-size: 0.9em; margin-bottom: 0.3em;", "Growth & Mix tab")
            ),
            div(
              style = "padding: 0.5em 1em; background: #107C10; color: white; border-radius: 4px; font-weight: 600; font-size: 0.85em;",
              "Directionally supported"
            )
          ),
          p(
            style = "color: #323130; line-height: 1.6; margin-top: 0.8em;",
            HTML(sprintf("Revenue CAGR accelerated by <strong>%.1fpp</strong> (%.1f%% → %.1f%%) alongside an expansion in Intelligent Cloud <strong>%.1fpp</strong> to 41.7%% of revenue.",
                         cagr_acceleration, cagr_early_pct, cagr_late_pct, cloud_change))
          )
        ),
        
        # H2
        div(
          style = "margin-bottom: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
          div(
            style = "display: flex; justify-content: space-between; align-items: center;",
            div(
              style = "flex: 1;",
              h4("H2: Margin expansion reflects revenue mix shift", 
                 style = "color: #004578; margin-bottom: 0.5em;"),
              div(style = "color: #605E5C; font-size: 0.9em; margin-bottom: 0.3em;", "Profitability Drivers tab")
            ),
            div(
              style = "padding: 0.5em 1em; background: #107C10; color: white; border-radius: 4px; font-weight: 600; font-size: 0.85em;",
              "Partially supported"
            )
          ),
          p(
            style = "color: #323130; line-height: 1.6; margin-top: 0.8em;",
            HTML(sprintf("Operating margin expanded <strong>%.1fpp</strong> (28.6%% → 41.8%%) while R&D intensity remained relatively stable at ~<strong>%.1f%%</strong>.",
                         op_margin_expansion, avg_rnd))
          )
        ),
        
        # H3
        div(
          style = "margin-bottom: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
          div(
            style = "display: flex; justify-content: space-between; align-items: center;",
            div(
              style = "flex: 1;",
              h4("H3: Cash generation resilient despite growth investments", 
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
            HTML(sprintf("FCF margin averaged <strong>%.1f%%</strong> across FY2016-2023.",
                         avg_fcf_margin))
          )
        ),
        
        # H4
        div(
          style = "margin-bottom: 1.5em; padding-left: 1em; border-left: 3px solid #0078D4;",
          div(
            style = "display: flex; justify-content: space-between; align-items: center;",
            div(
              style = "flex: 1;",
              h4("H4: Capital efficiency improved over the period", 
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
            HTML(sprintf("Revenue per dollar of assets increased <strong>%.1f%%</strong>.",
                         rev_per_asset_change))
          )
        ),
        
        # H5
        div(
          style = "margin-bottom: 0; padding-left: 1em; border-left: 3px solid #0078D4;",
          div(
            style = "display: flex; justify-content: space-between; align-items: center;",
            div(
              style = "flex: 1;",
              h4("H5: Balance sheet strength provides capital flexibility", 
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
            HTML(sprintf("Strong cash position ($<strong>%.1fB</strong>) and moderate leverage support financial flexibility, without assessing future allocation decisions.",
                         cash_2023))
          )
        )
      )
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
          <li>Revenue growth and margin expansion occurred alongside a rising contribution from cloud-related segments</li>
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