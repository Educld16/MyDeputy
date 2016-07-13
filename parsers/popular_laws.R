library(httr)
library(stringr)
# sample page: http://zakon0.rada.gov.ua/laws/main/dv20151001
# law_id, law_name, law_page_visits
stop_date <- as.POSIXlt(Sys.Date())
start_date <- stop_date
start_date$year <- start_date$year-2  # download data for 2 years
stop_date <- as.Date(seq(stop_date, length = 2, by = "-1 days")[2])  # no information about current day can be retrieved
start_date <- as.Date(start_date)
print(start_date)  # print current period
print(stop_date)
add_date <- function(start_date, offset="1 day"){  # iterations
  return(as.Date(seq(as.POSIXlt(start_date), length = 2, by = offset)[2]))
}
get_url <- function(dt){  # generate url
  return(format(dt,"http://zakon0.rada.gov.ua/laws/main/dv%Y%m%d"))
}
get_content_by_date <- function(dt){
  # TODO: rewrite this function
  url <- get_url(dt)
  t <- content(GET(url),"text",encoding="windows-1251")  # download html
  t <- paste('1,', unlist(strsplit(t, split='r(1,', fixed=T))[2], sep='')  # cut data
  t <- gsub('\n', '', gsub('l(4);', '', t, fixed=T), fixed=T)
  t <- gsub("(\\);--></script)(.*)","", t)
  t <- unlist(strsplit(t, split=');r(', fixed=T))  # split data
  name <- vector()
  id <- vector()
  count <- vector()
  date <- vector()
  # some strange string processing
  for(i in 1:length(t)){
    name <- c(name, gsub("(</a>)(.*)","",unlist(strsplit(t[i], split='=_blank>', fixed=T))[2]))
    id <- c(id, gsub("(</b>)(.*)","",unlist(strsplit(t[i], split='№ <b>', fixed=T))[2]))
    count <- c(count, gsub("(')(.*)","",unlist(strsplit(t[i], split="'','','','", fixed=T))[2]))
    date <- format(dt, "%Y%m%d")
  }
  laws <- data.frame(name=name, id=id, count=count, date=date)
}
laws<-get_content_by_date(start_date)
while(start_date!=stop_date){  # get all data for period
  start_date <- add_date(start_date)
  laws2 <- get_content_by_date(start_date)
  delay <- 16
  while (nrow(laws2) < 50){  # handle troubles
    if (delay>64){
      if(readline(paste(paste("skip", get_url(start_date)), "? ")) == "y") break;
    }
    if (delay>128){  # probably got ban from rada.gov.ua :(
      readline("change ip and press enter...")  # notify user and wait for indulgence
      delay <- 8
    }
    print(delay)  # current delay
    Sys.sleep(delay)
    delay <- delay * 2
    laws2 <- get_content_by_date(start_date)  # parse again
  }
  laws <- rbind(laws, laws2)
  print(start_date)  # make process less boring
  print(nrow(laws))
}
write.csv(laws, "popular_laws.csv")  # save data