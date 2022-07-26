# Load packages -----
library(tidyverse)
library(dplyr)

# Read data -----
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge by SCC
NEI <- merge(NEI,SCC)

# Calculate total coal combustion emissions by year ----
emissions_us_coal_combustion <- NEI %>% 
    subset(grepl("Combustion",SCC.Level.One)) %>%
    subset(grepl("Coal|Lignite",SCC.Level.Three)) %>% 
    group_by(year) %>% 
    summarize(total_emissions=sum(Emissions))

# Plot total emissions over time
png(filename = "plot4.png", width = 640, height = 480)
with(emissions_us_coal_combustion,barplot(total_emissions,names.arg = year, xlab="Year",main="Total PM2.5 emissions from coal combustion in the US"))
dev.off()