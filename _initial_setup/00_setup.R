# ==============================================================================
# Initial Setup Script for Microsoft Financial Dashboard
# Author: Steven Ponce
# Purpose: Install packages, create folders, configure deployment exclusions
# 
# ⚠️ RUN THIS ONCE, MANUALLY — NEVER SOURCE IN APP
# ==============================================================================

cat("\n💼 Setting up Microsoft Financial Dashboard Project...\n")
cat(paste(rep("=", 70), collapse = ""), "\n\n")

# --- STEP 1: Set CRAN Mirror --------------------------------------------------

cat("🔧 Setting CRAN mirror to RStudio cloud...\n")
options(repos = c(CRAN = "https://cloud.r-project.org"))
cat("✅ CRAN mirror set\n\n")

# --- STEP 2: Ensure 'pak' is installed ----------------------------------------

if (!requireNamespace("pak", quietly = TRUE)) {
  cat("📦 Installing 'pak' package manager...\n")
  install.packages("pak", quiet = TRUE)
  cat("✅ pak installed\n\n")
}

# --- STEP 3: Define Package List ----------------------------------------------

cat("📋 Defining modern business dashboard package stack...\n\n")

packages <- c(
  # === CORE SHINY & UI ===
  "shiny",
  "bslib",              # Modern Bootstrap 5 theming
  "shinyjs",            # JavaScript utilities
  "shinyWidgets",       # Enhanced input controls
  
  # === APPSILON FRAMEWORK (Professional UI) ===
  "shiny.semantic",     # Semantic UI components
  "semantic.dashboard", # Dashboard layouts with Semantic UI
  # "shiny.router",     # Optional: multi-page routing (uncomment if needed)
  
  # === DATA WRANGLING ===
  "dplyr",
  "tidyr",
  "readr",
  "stringr",
  "lubridate",
  "janitor",            # Clean column names
  "glue",               # String interpolation
  
  # === DATA ACCESS ===
  "httr2",              # Modern HTTP client for SEC API
  "jsonlite",           # JSON parsing
  # "arrow",            # Parquet support (future-proofing, optional for now)
  
  # === VISUALIZATION ===
  "ggplot2",
  "ggiraph",            # Interactive ggplot2 (SVG-based, fast)
  "plotly",             # Interactive charts (alternative/complement to ggiraph)
  "scales",             # Number/axis formatting
  "RColorBrewer",       # Color palettes
  "viridis",            # Perceptually uniform colors
  "thematic",           # Auto-theming for plots
  
  # === TABLES ===
  "reactable",          # Modern, fast, professional data tables
  "DT",                 # Alternative table package (if needed)
  
  # === UTILITIES ===
  "here",               # Project-relative paths
  "fs",                 # File system operations
  "purrr",              # Functional programming
  
  # === DEVELOPMENT ===
  "testthat",           # Unit testing (optional but good practice)
  "usethis"             # Project setup utilities
)

cat("📦 Package stack defined:\n")
cat("   - Core Shiny & UI: 4 packages\n")
cat("   - Appsilon Framework: 2 packages\n")
cat("   - Data wrangling: 7 packages\n")
cat("   - Data access: 2 packages\n")
cat("   - Visualization: 7 packages\n")
cat("   - Tables: 2 packages\n")
cat("   - Utilities: 3 packages\n")
cat("   - Development: 2 packages\n\n")

# --- STEP 4: Install Packages with pak ----------------------------------------

cat("🚀 Installing packages with pak (this may take a few minutes)...\n\n")

tryCatch({
  pak::pkg_install(packages)
  cat("\n✅ All packages installed/updated successfully!\n\n")
}, error = function(e) {
  cat("\n❌ Error during package installation:\n")
  cat("   ", conditionMessage(e), "\n\n")
  cat("   Please review error messages above and retry manually if needed.\n\n")
})

# --- STEP 5: Create Project Folders -------------------------------------------

cat("📁 Creating project folder structure...\n")

dirs <- c(
  "data-raw/cache",
  "data/processed",
  "R",
  "www",
  "docs",
  "_initial_setup"
)

for (d in dirs) {
  fs::dir_create(d)
  cat(sprintf("  ✅ %s/\n", d))
}
cat("\n")

# --- STEP 6: Create .rscignore ------------------------------------------------

cat("📝 Creating .rscignore for clean shinyapps.io deployment...\n")

rscignore_content <- "# Exclude from shinyapps.io deployment
# (Keeps bundle size small and avoids OS-specific binaries)

renv/library
renv/staging
renv/python
.Rproj.user
rsconnect
docs
screenshots
_initial_setup
*.Rproj
.git
.gitignore
README.md
references.md
data-raw
"

writeLines(rscignore_content, ".rscignore")
cat("✅ .rscignore created\n\n")

# --- STEP 7: Create .gitignore ------------------------------------------------

cat("📝 Creating .gitignore...\n")

gitignore_content <- "# R & RStudio
.Rproj.user
.Rhistory
.RData
.Ruserdata
*.Rproj

# Deployment
rsconnect/

# Cache & temporary files
data-raw/cache/*.json
*.log

# Data (optional — decide if you want to track processed data)
# data/processed/*.rds
# data/processed/*.csv
"

writeLines(gitignore_content, ".gitignore")
cat("✅ .gitignore created\n\n")

# --- STEP 8: Create data preparation template ---------------------------------

cat("📝 Creating data preparation script templates...\n")

# Already covered by your 01_pull and 02_build scripts
# (No need for redundant template here)

cat("✅ Data pipeline scripts ready in data-raw/\n\n")

# --- STEP 9: Create runtime-safe setup helper ---------------------------------

cat("📝 Creating R/setup_runtime.R (safe for app deployment)...\n")

runtime_setup <- '# ==============================================================================
# Runtime Setup (Safe for Deployment)
# Author: Steven Ponce
# Purpose: Constants, options, and helpers — NO INSTALLATIONS
# ==============================================================================

# --- Color Palette (Professional, Corporate) ----------------------------------

msft_colors <- list(
  primary   = "#0078D4",  # Microsoft Blue
  secondary = "#50E6FF",  # Light Blue
  success   = "#107C10",  # Green
  warning   = "#FFB900",  # Gold
  danger    = "#E81123",  # Red
  dark      = "#243A5E",  # Dark Blue
  light     = "#F3F2F1",  # Light Gray
  text      = "#323130"   # Dark Gray
)

# --- ggplot2 Theme (Consulting-Grade) -----------------------------------------

theme_msft <- function(base_size = 12) {
  ggplot2::theme_minimal(base_size = base_size) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", size = base_size * 1.3, 
                                         color = msft_colors$dark),
      plot.subtitle = ggplot2::element_text(color = msft_colors$text, 
                                            margin = ggplot2::margin(b = 10)),
      axis.title = ggplot2::element_text(face = "bold", color = msft_colors$text),
      axis.text = ggplot2::element_text(color = msft_colors$text),
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(color = "#E1DFDD", linewidth = 0.3),
      legend.position = "top",
      legend.title = ggplot2::element_text(face = "bold", size = base_size * 0.9),
      plot.background = ggplot2::element_rect(fill = "white", color = NA),
      panel.background = ggplot2::element_rect(fill = "white", color = NA)
    )
}

# --- Number Formatting Helpers ------------------------------------------------

fmt_currency <- function(x, prefix = "$", suffix = "", digits = 0) {
  scales::label_dollar(
    prefix = prefix,
    suffix = suffix,
    scale = 1e-9,  # Billions
    accuracy = 10^-digits
  )(x)
}

fmt_percent <- function(x, digits = 1) {
  scales::label_percent(accuracy = 0.1^digits)(x)
}

fmt_number <- function(x, suffix = "", scale = 1, digits = 1) {
  scales::label_number(
    suffix = suffix,
    scale = scale,
    accuracy = 0.1^digits
  )(x)
}

# --- Shiny Options (Performance & UX) -----------------------------------------

options(
  shiny.maxRequestSize = 30 * 1024^2,  # 30MB upload limit
  spinner.type = 4,                     # Loading spinner style
  spinner.color = msft_colors$primary
)
'

fs::dir_create("R")
writeLines(runtime_setup, "R/setup_runtime.R")
cat("✅ R/setup_runtime.R created\n\n")

# --- FINAL MESSAGE ------------------------------------------------------------

cat(paste(rep("=", 70), collapse = ""), "\n")
cat("✨ Microsoft Financial Dashboard Setup Complete!\n")
cat(paste(rep("=", 70), collapse = ""), "\n\n")

cat("📋 NEXT STEPS:\n\n")
cat("1. ✅ Run data-raw/01_pull_sec_companyfacts.R\n")
cat("      (Update SEC_USER_AGENT first!)\n\n")
cat("2. ✅ Run data-raw/02_build_financials_fy.R\n")
cat("      (Creates clean FY2016-FY2023 dataset)\n\n")
cat("3. ✅ Inspect data/processed/msft_financials_fy.csv\n")
cat("      (Verify 8 rows with revenue, margins, cash flow)\n\n")
cat("4. ✅ Move to Part 2: Hypothesis refinement + app design\n\n")

cat("⚠️  IMPORTANT REMINDERS:\n")
cat("   - NEVER source 00_setup.R in your app\n")
cat("   - NEVER install packages at runtime\n")
cat("   - Use R/setup_runtime.R for constants/helpers only\n")
cat("   - Keep data-raw/ scripts separate (excluded from deployment)\n\n")

cat("🚀 Ready to build a consulting-grade financial dashboard!\n\n")