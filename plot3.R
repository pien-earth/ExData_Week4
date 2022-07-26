# Load packages -----
library(tidyverse)
library(dplyr)

# Read data -----
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate total emissions per year by type for Baltimore City----
emissions_baltimore_type <- NEI %>%
    subset(fips=="24510") %>%
    group_by(year,type) %>%
    summarize(total_emissions=sum(Emissions))

# Plot total emissions over time using the ggplot2 plotting system
png(filename = "plot3.png", width = 640, height = 480)
ggplot(emissions_baltimore_type,aes(factor(year),total_emissions,group=type,fill=type)) +
    facet_grid(. ~ type) +
    geom_bar(stat="identity",position=position_dodge()) +
    xlab("Year") +
    ylab("") +
    ggtitle("Total PM2.5 emissions Baltimore City by type")
dev.off()