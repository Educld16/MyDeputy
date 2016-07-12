library(foreign)  # library for import
poll_data <- read.dta("ESS6UA.dta")  # import stata file
write.csv(poll_data, "poll_data.csv")  # write data to csv
