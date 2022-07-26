# Load packages -----
library(tidyverse)
library(dplyr)

# Read data -----
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge by SCC
NEI <- merge(NEI,SCC)

# Calculate total vehicle emissions by year for Baltimore City ----
emissions_baltimore_vehicles <- NEI %>%
    subset(fips=="24510") %>%
    subset(grepl("Vehicle",SCC.Level.Two)) %>%
    group_by(year) %>% 
    summarize(total_emissions=sum(Emissions))

# Plot total emissions over time ----
png(filename = "plot5.png", width = 640, height = 480)
with(emissions_baltimore_vehicles,barplot(total_emissions,names.arg = year, xlab="Year",main="Total PM2.5 emissions from vehicles in Baltimore City"))
dev.off()