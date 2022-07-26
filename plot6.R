# Load packages -----
library(tidyverse)
library(dplyr)

# Read data -----
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge by SCC
NEI <- merge(NEI,SCC)

# Calculate change in total coal vehicle emissions by city by year ----
emissions_la_baltimore_vehicles <- NEI %>%
    subset(fips=="24510"|fips=="06037") %>%
    subset(grepl("Vehicle",SCC.Level.Two)) %>%
    group_by(year,fips) %>%
    summarize(total_emissions=sum(Emissions)) %>%
    mutate(city = factor(fips,labels=c("Los Angeles","Baltimore City"))) %>% 
    group_by(fips) %>% 
    mutate(relative_emissions_to1999 = total_emissions / total_emissions[1] * 100)

# Plot change in emissions over time using the base plotting system
png(filename = "plot6.png", width = 640, height = 480)
ggplot(emissions_la_baltimore_vehicles,aes(factor(year),relative_emissions_to1999,group=city,fill=city)) +
    facet_grid(. ~ city) +
    geom_bar(stat="identity",position=position_dodge()) +
    xlab("Year") +
    ylab("% of value relative to 1999") +
    ggtitle("Change in total PM2.5 emissions from vehicles in Los Angeles and Baltimore City") +
    labs(fill="City")
dev.off()