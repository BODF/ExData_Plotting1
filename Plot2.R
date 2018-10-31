#

# Load useful packages
library(readr)
library(lubridate)
library(dplyr)
library(tidyr)

# Read the data in.
## col_types will convert the first two columns to character, else to numeric
## NA's are '?' in this dataset
## I found that we only need to read in the first 70000 lines to get the dates
data <- read_delim('household_power_consumption.txt', delim = ';',
                   col_names = TRUE, col_types = 'ccddddddd',
                   na = "?", n_max = 70000)

## First: Combine the 'Date' and 'Time' columns and convert to a time class
## Second: Remove the now redundant Time column
## Third: Grab the rows where the date falls in our desired range
data <-  data %>%
        mutate(Date = dmy_hms(paste(Date, Time))) %>%
        select(-Time) %>%
        filter(Date >= dmy('1/2/2007') & Date < dmy('3/2/2007'))

## Make the histogram and print it to a png file that is 480x480 pixels
png('./Plot2.png', width = 480, height = 480, units = 'px')
with(data, plot(Date, Global_active_power,
                ylab='Global Active Power (kilo Watts)', xlab = '', type='l'))
dev.off()