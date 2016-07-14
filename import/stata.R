library(foreign)  # library for import
poll_data <- read.dta("ESS6UA.dta")  # import stata file
write.csv(poll_data, "./poll_data.csv")  # write data to csv
w<-vector()
for (x in colnames(poll_data)){
  w<-c(w,length(levels(as.factor(as.character(poll_data[[x]])))))  # count levels
}
d<-data.frame(name=colnames(poll_data),levels=w)  # create data frame from levels and var names
pdata<-poll_data[ , !(names(poll_data) %in% d[d$levels<=1,]$name)]  # drop vars where var.level<=1
pvalue<-vector()
for (x in colnames(pdata)){
  chisq.test(pdata[[x]],pdata[["prtcldua"]])[["p.value"]]
  pvalue<-c(pvalue,chisq.test(pdata[[x]],pdata[["prtcldua"]])[["p.value"]])  # chisq.test for pairs result-other_var
}
dp<-data.frame(name=colnames(pdata),pvalue=pvalue)
dp<-dp[dp$pvalue>0.05,]  # filter by p.value