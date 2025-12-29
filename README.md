# Microsoft Financial Analysis Dashboard
**Portfolio project by Steven Ponce**

---

## Purpose

This dashboard is an independent analytical exercise using publicly available financial disclosures from Microsoft Corporation (CIK 0000789019). The objective is to demonstrate analytical rigor, decision-support design, and transparent data engineering for a portfolio showcase.

**This is not:**
- Official company reporting
- Investment advice
- Forward-looking guidance
- A valuation model

Figures are simplified and re-aggregated from SEC filings for illustrative purposes only.

---

## Scope

**Time period:** FY2016–FY2023 (fiscal years ending June 30)

**Data sources:**
- SEC EDGAR XBRL Company Facts API
- Microsoft 10-K annual filings

**Analysis focus:**
- Revenue growth and segment mix
- Profitability dynamics (gross, operating margins)
- Cash generation and capital allocation patterns
- Balance sheet composition trends

**Out of scope:**
- Stock price analysis
- Valuation multiples
- Forward guidance interpretation
- Quarterly earnings

---

## Hypotheses (Pre-Analysis)

All hypotheses are exploratory and evaluated against reported historical data. Acceptance or rejection reflects analytical interpretation, not validation by Microsoft.

**H1:** Revenue growth is increasingly concentrated in specific segments (cloud vs. legacy).

**H2:** Margin expansion is driven primarily by business mix shifts rather than cost compression.

**H3:** Cash generation (operating cash flow, free cash flow proxy) remains resilient despite growth investments.

**H4:** Balance sheet strength (cash vs. debt) supports sustained capital returns (dividends, buybacks).

**H5:** Operating leverage inflection points are visible in FY2020–FY2023.

*(Hypothesis evaluation will be documented in the project write-up.)*

---

## Methodology

### Data Pipeline

1. **Extract:** Pull structured XBRL data from SEC API (`data-raw/01_pull_sec_companyfacts.R`)
2. **Transform:** Filter to FY2016–FY2023, derive margins, growth rates (`data-raw/02_build_financials_fy.R`)
3. **Load:** Export clean tables to `data/processed/`

### Dashboard Design

- **Stakeholder-focused:** Executive, analyst, and data explorer personas
- **Progressive disclosure:** High-level → detailed as needed
- **Defensible:** All metrics traceable to source line items

---

## Disclaimers

### Purpose Disclaimer
This dashboard is an independent analytical exercise using publicly available financial disclosures. Figures are simplified and re-aggregated for illustrative purposes only and do not represent official company reporting, forecasts, or investment advice.

### Hypothesis Disclaimer
All hypotheses are exploratory and are evaluated against reported historical data. Acceptance or rejection reflects analytical interpretation, not validation by Microsoft.

### Scope Disclaimer
The analysis focuses on historical financial structure and sensitivity, not valuation, guidance, or future performance.

---

## Technical Stack

- **Data:** R + `httr2`, `jsonlite`, `dplyr`, `tidyr`
- **Dashboard:** Shiny (Appsilon framework), `shiny.semantic`, `reactable`, `ggiraph`
- **Deployment:** shinyapps.io

---

## References

See `references.md` for all source links, XBRL concept definitions, and filing URLs.

---

**Contact:** Steven Ponce 
**License:** MIT (code only; data remains property of Microsoft and SEC)