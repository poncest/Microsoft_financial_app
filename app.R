# ==============================================================================
# Microsoft Financial Analysis Dashboard
# Author: Steven Ponce
# Purpose: Strategic financial analysis for portfolio demonstration
# ==============================================================================

# This is a Shiny web application

# Load global setup (sources data, UI, charts)
source("global.R")

# Load server
source("server.R")

# Run app
shinyApp(ui = ui, server = server)


