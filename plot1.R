# Load packages -----
library(tidyverse)
library(dplyr)

# Read data -----
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate total emissions per year for entire US----
emissions_all <- NEI %>%
    group_by(year) %>%
    summarize(total_emissions=sum(Emissions))

# Plot total US emissions over time using the base plotting system ----
png(filename = "plot1.png", width = 640, height = 480)
barplot(emissions_all$total_emissions,names.arg = emissions_all$year,xlab="Year",main="Total PM2.5 emissions United States")
dev.off()