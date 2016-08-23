# Introduction
# We will be using the "Individual household electric power consumption Data Set"

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Measurements of electric power consumption in
# one household with a one-minute sampling rate over a period of almost 4 years. 
# Different electrical quantities and some sub-metering values are available.
# The following descriptions of the 9 variables in the dataset

# Date: Date in format dd/mm/yyyy
# Time: Time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered)
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# Loading the data

setwd("/Users/johnryanzelling/Downloads")
filename <- "household_power_consumption.txt"

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# You may find it useful to convert the Date and Time variables to Date/Time classes 
# in R using the `strptime()` and `as.Date()` functions
# Note that in this dataset missing values are coded as `?`
# Making Plots

#Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. 
#Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
# Name each of the plot files as `plot1.png`, `plot2.png`, etc.

# Create `plot1.R`, `plot2.R`, `plot3.R` and `plot4.R`
# Each code file should include code for reading the data so that the plot can be fully reproduced
# Add the PNG file and R code file to your git repository

#Library for histogram
library(datasets)

### Plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
#x-axis: Global Active Power (kilowatts)
#y-axis: Frequency
#Title: Global Active Power
dev.off()

### Plot 2
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
#x-axis: Thu, Fri, Sat
#y-axis: Global Active Power
#No Title
dev.off()

### Plot 3
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
#x-axis: Thu, Fri, Sat
#y-axis: Energy sub metering
#Legend: Sub metering 1, Sub metering 2, Sub metering 3
dev.off()

### Plot 4
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
#par(mrow = 2, mcol = 2)
dev.off()
