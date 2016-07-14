library(foreign)  # library for import
poll_data <- read.dta("ESS6UA.dta")  # import stata file
write.csv(poll_data, "./poll_data.csv")  # write data to csv
w<-vector()
for (x in colnames(poll_data)){
  w<-c(w,length(levels(poll_data[[x]])))  # count levels
}
d<-data.frame(name=colnames(poll_data),levels=w)  # create data frame from levels and var names
pdata<-poll_data[ , !(names(poll_data) %in% d[d$levels<=1,]$name)]  # drop vars where var.level<=1